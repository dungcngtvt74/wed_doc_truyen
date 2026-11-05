package com.web_doc_truyen.backend.nguoidung;

public class nguoidungDTO {
    private Integer id;
    private String tenDangNhap;
    private String email;
    private String vaiTro;

    public nguoidungDTO(nguoidung nd) {
        this.id = nd.getId();
        this.tenDangNhap = nd.getTendangnhap();
        this.email = nd.getEmail();
        this.vaiTro = nd.getVaitro();
    }

    public Integer getId() { return id; }
    public String getTenDangNhap() { return tenDangNhap; }
    public String getEmail() { return email; }
    public String getVaiTro() { return vaiTro; }
}