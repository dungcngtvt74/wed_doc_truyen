package com.web_doc_truyen.backend.chuong.ccchuong;


import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;

@Entity
@Table(name = "chuong")
public class chuong {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @JsonProperty("id_truyen")
    @Column(name = "id_truyen")
    private Integer idtruyen;


    @JsonProperty("so_chuong")
    @Column( name = "so_chuong")
    private Integer sochuong;

    @JsonProperty("tieu_de")
    @Column(name = "tieu_de")
    private String tieu_de;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getIdtruyen() {
        return idtruyen;
    }

    public void setIdtruyen(Integer idtruyen) {
        this.idtruyen = idtruyen;
    }

    public Integer getSochuong() {
        return sochuong;
    }

    public void setSochuong(Integer sochuong) {
        this.sochuong = sochuong;
    }

    public String getTieu_de() {
        return tieu_de;
    }

    public void setTieu_de(String tieu_de) {
        this.tieu_de = tieu_de;
    }
}
