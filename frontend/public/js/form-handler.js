(function () {
    function setMessage(box, color, text) {
        if (!box) return;
        box.style.color = color;
        box.textContent = text;
    }

    function getFormData(form, options) {
        if (options.payload) {
            return options.payload(form);
        }

        if (options.useJson) {
            const formData = new FormData(form);
            const data = {};
            formData.forEach((value, key) => {
                data[key] = value;
            });
            return JSON.stringify(data);
        }

        return new FormData(form);
    }

    function isSuccessResult(data, response) {
        if (response && response.ok === false) {
            return false;
        }

        if (typeof data === 'object' && data !== null) {
            if (data.success === false || data.Success === false) {
                return false;
            }
            if (data.success === true || data.Success === true) {
                return true;
            }
            if (data.status && typeof data.status === 'string') {
                const status = data.status.toLowerCase();
                if (status === 'error') return false;
                if (status === 'success') return true;
            }
            if (data.message && typeof data.message === 'string') {
                const message = data.message.toLowerCase();
                if (message.includes('lỗi') || message.includes('error') || message.includes('thất bại')) {
                    return false;
                }
            }
            if (data.error || data.Error) {
                return false;
            }
            if (response && response.ok) {
                return true;
            }
        }

        if (typeof data === 'string' && data.trim().length > 0) {
            const lower = data.toLowerCase();
            if (lower.includes('error') || lower.includes('lỗi') || lower.includes('thất bại')) {
                return false;
            }
            return true;
        }

        return Boolean(response && response.ok);
    }

    window.bindAjaxForm = function (form, options) {
        if (!form) return;

        const messageBox = options.messageBox || form.querySelector('[data-form-message], #api-message');
        const submitButton = options.submitButton || form.querySelector('button[type="submit"], button:not([type])');
        const method = (options.method || form.getAttribute('data-method') || form.getAttribute('method') || 'POST').toUpperCase();
        const url = options.url || form.getAttribute('action') || form.getAttribute('data-action');

        if (!url) return;

        const buttonOriginalText = submitButton ? submitButton.textContent : '';

        form.addEventListener('submit', async function (event) {
            event.preventDefault();

            if (form.dataset.submitting === 'true') {
                return;
            }

            form.dataset.submitting = 'true';

            if (messageBox) {
                setMessage(messageBox, 'blue', options.processingText || 'Đang xử lý...');
            }

            if (submitButton) {
                submitButton.disabled = true;
                submitButton.dataset.originalText = buttonOriginalText;
                submitButton.textContent = options.processingText || 'Đang xử lý...';
            }

            try {
                const payload = getFormData(form, options);
                const headers = options.headers ? { ...options.headers } : {};

                if (options.useJson && !headers['Content-Type']) {
                    headers['Content-Type'] = 'application/json';
                }

                const response = await fetch(url, {
                    method,
                    headers,
                    body: payload
                });

                const contentType = response.headers.get('content-type') || '';
                const data = contentType.includes('application/json')
                    ? await response.json()
                    : await response.text();

                const success = isSuccessResult(data, response);

                if (success && options.onSuccess) {
                    const callbackResult = options.onSuccess(data, response, form);
                    if (callbackResult === false) {
                        return;
                    }
                }

                if (success) {
                    if (messageBox) {
                        const successMessage = (typeof data === 'object' && data !== null && data.message)
                            ? data.message
                            : options.successText || 'Thành công';
                        setMessage(messageBox, 'green', successMessage);
                    }
                    return;
                }

                if (options.onError) {
                    options.onError(data, response, form);
                    return;
                }

                if (messageBox) {
                    const errorMessage = (typeof data === 'object' && data !== null && data.message)
                        ? data.message
                        : options.errorText || 'Thao tác thất bại';
                    setMessage(messageBox, 'red', errorMessage);
                }
            } catch (error) {
                if (messageBox) {
                    setMessage(messageBox, 'red', options.errorText || 'Lỗi kết nối máy chủ');
                }
                if (options.onError) {
                    options.onError(error);
                }
            } finally {
                form.dataset.submitting = 'false';

                if (submitButton) {
                    submitButton.disabled = false;
                    submitButton.textContent = submitButton.dataset.originalText || buttonOriginalText;
                    delete submitButton.dataset.originalText;
                }
            }
        });
    };
})();
