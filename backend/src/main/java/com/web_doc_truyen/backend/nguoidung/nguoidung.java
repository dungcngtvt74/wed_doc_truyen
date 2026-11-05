package com.web_doc_truyen.backend.nguoidung;

import jakarta.persistence.*;

@Entity
@Table(name = "nguoidung")
public class nguoidung {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ten_dang_nhap", unique = true, nullable = false)
    private String tendangnhap;

    @Column(name = "mat_khau", nullable = false)
    private String matkhau;

    private String email;

    @Column(name = "vai_tro")
    private String vaitro = "user";


    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getTendangnhap() { return tendangnhap; }
    public void setTendangnhap(String tendangnhap) { this.tendangnhap = tendangnhap; }

    public String getMatkhau() { return matkhau; }
    public void setMatkhau(String matkhau) { this.matkhau = matkhau; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getVaitro() { return vaitro; }
    public void setVaitro(String vaitro) { this.vaitro = vaitro; }
}