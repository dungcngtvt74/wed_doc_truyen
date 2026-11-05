(function () {
    function goTo(target) {
        function fallbackHome() {
            window.location.href = '../../public/index.html';
        }

        if (!target || target === '#') {
            if (window.history.length > 1) {
                window.history.back();
            } else if (document.referrer && document.referrer !== '') {
                window.location.href = document.referrer;
            } else {
                fallbackHome();
            }
            return;
        }

        if (target === 'back') {
            if (window.history.length > 1) {
                window.history.back();
            } else if (document.referrer && document.referrer !== '') {
                window.location.href = document.referrer;
            } else {
                fallbackHome();
            }
            return;
        }

        window.location.href = target;
    }

    document.addEventListener('DOMContentLoaded', function () {
        document.addEventListener('click', function (event) {
            const link = event.target.closest('a[data-nav]');
            if (!link) return;

            const target = link.getAttribute('data-nav');
            if (!target) return;

            event.preventDefault();
            goTo(target);
        });
    });

    window.navigateTo = goTo;
    window.goBack = function () {
        goTo('back');
    };
})();
