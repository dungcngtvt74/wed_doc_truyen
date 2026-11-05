package com.web_doc_truyen.backend.hoso_user;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import java.time.LocalDate;

@Entity
@Table(name = "hoso_nguoidung")
public class hoso_user {

    @Id
    @Column(name = "id_nguoidung")
    private Integer iduser;


    @Column(name = "ho_ten")
    private String hoten;

    @Column(name = "ngay_sinh")
    private LocalDate ngaysinh;

    @Column(name = "gioi_tinh")
    private String gioitinh;

    @Column(name = "so_dien_thoai",unique = true)
    private String sodienthoai;

    @Column(name = "dia_chi")
    private String diachi;

    private String avatar;


    public Integer getIduser() {
        return iduser;
    }

    public void setIduser(Integer iduser) {
        this.iduser = iduser;
    }

    public String getHo_ten() {
        return hoten;
    }

    public void setHo_ten(String ho_ten) {
        this.hoten = ho_ten;
    }

    public LocalDate getNgaysinh() {
        return ngaysinh;
    }

    public void setNgaysinh(LocalDate ngaysinh) {
        this.ngaysinh = ngaysinh;
    }

    public String getGioitinh() {
        return gioitinh;
    }

    public void setGioitinh(String gioitinh) {
        this.gioitinh = gioitinh;
    }

    public String getSodienthoai() {
        return sodienthoai;
    }

    public void setSodienthoai(String sodienthoai) {
        this.sodienthoai = sodienthoai;
    }

    public String getDiachi() {
        return diachi;
    }

    public void setDiachi(String diachi) {
        this.diachi = diachi;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
}
