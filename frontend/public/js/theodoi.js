const followedStoryIds = new Set();
let listenersBound = false;
let refreshTimeout = null;

function ensureToastContainer() {
    let container = document.getElementById('toastContainer');
    if (!container) {
        container = document.createElement('div');
        container.id = 'toastContainer';
        container.className = 'toast-container';
        document.body.appendChild(container);
    }
    return container;
}

function showToast(message, type = 'success') {
    const container = ensureToastContainer();
    const toast = document.createElement('div');
    toast.className = `toast toast-${type}`;
    toast.textContent = message;
    container.appendChild(toast);
    setTimeout(() => {
        toast.classList.add('show');
    }, 10);
    setTimeout(() => {
        toast.classList.remove('show');
        setTimeout(() => toast.remove(), 260);
    }, 2200);
}

function redirectToLogin() {
    window.location.href = '/web_doc_truyen/frontend/view/log/login.html';
}

function readStoredUser() {
    try {
        const raw = localStorage.getItem('user');
        return raw ? JSON.parse(raw) : null;
    } catch (error) {
        return null;
    }
}

async function loadFollowedIds() {
    followedStoryIds.clear();
    const user = readStoredUser();
    const userId = user ? (user.id || user.id_nguoidung || user.iduser) : null;
    
    if (!userId) {
        localStorage.removeItem('followedStoryIds');
        return;
    }

    try {
        const response = await fetch('http://localhost:8080/api/theo_doi_truyen/get_by_user', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ id_nguoidung: userId })
        });
        
        if (response.status === 401) {
            localStorage.removeItem('followedStoryIds');
            return;
        }
        const data = await response.json();
        if (response.ok && data.success && Array.isArray(data.data)) {
            data.data.forEach((item) => {
                const idValue = Number(item.id || item.id_truyen || 0);
                if (idValue) {
                    followedStoryIds.add(idValue);
                }
            });
            localStorage.setItem('followedStoryIds', JSON.stringify(Array.from(followedStoryIds)));
        }
    } catch (error) {
        console.warn('Lỗi khi tải danh sách theo dõi:', error);
    }
}

function updateFollowButton(button, isFollowing) {
    button.classList.toggle('is-following', isFollowing);
    button.classList.toggle('not-following', !isFollowing);
    button.textContent = isFollowing ? 'Đang theo dõi' : 'Theo dõi';
    button.title = isFollowing ? 'Bỏ theo dõi truyện này' : 'Theo dõi truyện này';
    button.setAttribute('aria-label', button.title);
}

function updateAllFollowButtons() {
    document.querySelectorAll('.follow-card-button').forEach((button) => {
        const storyId = Number(button.dataset.storyId || 0);
        if (!storyId) return;
        updateFollowButton(button, followedStoryIds.has(storyId));
    });
}

function bindFollowButtons() {
    document.querySelectorAll('.follow-card-button').forEach((button) => {
        if (button.dataset.boundFollowClick === '1') {
            return;
        }
        button.addEventListener('click', async (event) => {
            event.preventDefault();
            event.stopPropagation();
            
            const user = readStoredUser();
            const userId = user ? (user.id || user.id_nguoidung || user.iduser) : null;
            if (!userId) {
                window.alert('Bạn cần đăng nhập để theo dõi truyện.');
                redirectToLogin();
                return;
            }

            const storyId = Number(button.dataset.storyId || 0);
            if (!storyId) {
                showToast('Thiếu ID truyện để theo dõi.', 'error');
                return;
            }

            const isFollowingNow = button.classList.contains('is-following');
            const confirmed = window.confirm(
                isFollowingNow
                    ? 'Bỏ theo dõi truyện này không?'
                    : 'Theo dõi truyện này không?'
            );
            if (!confirmed) {
                return;
            }
            button.disabled = true;

            try {
                // Xác định gọi API add hay remove của Spring Boot
                const endpoint = isFollowingNow ? 'remove' : 'add';
                const response = await fetch(`http://localhost:8080/api/theo_doi_truyen/${endpoint}`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ id_truyen: storyId, id_nguoidung: userId })
                });

                const data = await response.json();
                
                if (response.ok && data.success) {
                    const nowFollowing = !isFollowingNow;
                    
                    if (nowFollowing) {
                        followedStoryIds.add(storyId);
                    } else {
                        followedStoryIds.delete(storyId);
                    }
                    
                    localStorage.setItem('followedStoryIds', JSON.stringify(Array.from(followedStoryIds)));
                    localStorage.setItem('followListUpdatedAt', String(Date.now()));
                    
                    updateFollowButton(button, nowFollowing);
                    showToast(nowFollowing ? 'Đã theo dõi truyện.' : 'Đã bỏ theo dõi truyện.', 'success');
                    
                    window.dispatchEvent(new CustomEvent('followingUpdated'));
                } else {
                    showToast(data.message || 'Không thể thay đổi trạng thái theo dõi.', 'error');
                }
            } catch (error) {
                console.error('Lỗi khi thay đổi theo dõi:', error);
                showToast('Lỗi mạng khi thay đổi theo dõi.', 'error');
            } finally {
                button.disabled = false;
            }
        });
        button.dataset.boundFollowClick = '1';
    });
}

function addFollowButtons() {
    document.querySelectorAll('.story-card').forEach((card) => {
        const storyId = card.dataset.storyId || 0;
        if (!storyId) return;
        const isFollowing = followedStoryIds.has(Number(storyId));
        let followBtn = card.querySelector('.follow-card-button');
        if (!followBtn) {
            followBtn = document.createElement('button');
            followBtn.type = 'button';
            followBtn.className = 'follow-card-button';
            followBtn.dataset.storyId = storyId;
            card.appendChild(followBtn);
        }
        updateFollowButton(followBtn, isFollowing);
    });
    bindFollowButtons();
}

function scheduleFollowRefresh() {
    if (refreshTimeout) {
        clearTimeout(refreshTimeout);
    }
    refreshTimeout = setTimeout(async () => {
        await loadFollowedIds();
        addFollowButtons();
        updateAllFollowButtons();
        refreshTimeout = null;
    }, 120);
}

function bindAutoRefreshEvents() {
    if (listenersBound) {
        return;
    }
    window.addEventListener('storage', function (event) {
        if (event.key === 'followListUpdatedAt' || event.key === 'followedStoryIds') {
            scheduleFollowRefresh();
        }
    });
    window.addEventListener('pageshow', function () {
        scheduleFollowRefresh();
    });
    window.addEventListener('focus', function () {
        scheduleFollowRefresh();
    });
    document.addEventListener('visibilitychange', function () {
        if (!document.hidden) {
            scheduleFollowRefresh();
        }
    });
    window.addEventListener('followingUpdated', function () {
        scheduleFollowRefresh();
    });
    listenersBound = true;
}

async function initializeTheoDoiTruyen() {
    await loadFollowedIds();
    addFollowButtons();
    updateAllFollowButtons();
    bindAutoRefreshEvents();
}

initializeTheoDoiTruyen();