package com.web_doc_truyen.backend.trang;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;

@Entity
@Table(name = "trang")
public class trang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @JsonProperty("id_chuong")
    @Column(name = "id_chuong")
    private Integer idchuong;

    @JsonProperty("so_trang")
    @Column(name = "so_trang")
    private Integer sotrang;

    @JsonProperty("loai")
    @Column(name = "loai")
    private String loai = "image";

    @JsonProperty("anh")
    @Column(name = "anh")
    private String anh;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getIdchuong() { return idchuong; }
    public void setIdchuong(Integer idchuong) { this.idchuong = idchuong; }

    public Integer getSotrang() { return sotrang; }
    public void setSotrang(Integer sotrang) { this.sotrang = sotrang; }

    public String getLoai() { return loai; }
    public void setLoai(String loai) { this.loai = loai; }

    public String getAnh() { return anh; }
    public void setAnh(String anh) { this.anh = anh; }
}