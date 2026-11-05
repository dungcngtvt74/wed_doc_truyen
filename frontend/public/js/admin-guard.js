// admin-guard.js
// Chặn truy cập các trang quản trị (thêm/sửa/xóa) nếu không phải tài khoản admin.
(function () {
    function getStoredUser() {
        try {
            const raw = localStorage.getItem('user');
            return raw ? JSON.parse(raw) : null;
        } catch (e) {
            return null;
        }
    }

    const user = getStoredUser();
    const vaiTro = user && (user.vaiTro || user.vai_tro);
    const idNguoiDung = user && (user.id || user.id_nguoidung || user.iduser);

    if (!user || !idNguoiDung) {
        alert('Bạn cần đăng nhập để truy cập trang này!');
        window.location.href = '/web_doc_truyen/frontend/view/log/login.html';
        throw new Error('Chưa đăng nhập');
    }

    if (String(vaiTro).toLowerCase() !== 'admin') {
        alert('Bạn không có quyền truy cập trang này!');
        window.location.href = '/web_doc_truyen/frontend/public/index.html';
        throw new Error('Không phải admin');
    }

    window.CURRENT_ADMIN_ID = idNguoiDung;
})();