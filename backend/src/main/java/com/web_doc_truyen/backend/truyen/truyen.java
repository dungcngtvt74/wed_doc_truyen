package com.web_doc_truyen.backend.truyen;

import jakarta.persistence.*;

@Entity
@Table(name = "truyen")
public class truyen {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_tacgia")
    private Integer idtacgia;

    @Column(name = "ten_truyen")
    private String tentruyen;

    @Column(name = "mo_ta", columnDefinition = "TEXT")
    private String mota;

    @Column(name = "trang_thai")
    private String trangthai;

    @Column(name = "anh_bia")
    private String anhbia;

    @Column(name = "luot_xem")
    private Integer luotxem = 0;

    @Column(name = "theloai_ids")
    private String theloaiids;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getIdtacgia() { return idtacgia; }
    public void setIdtacgia(Integer idtacgia) { this.idtacgia = idtacgia; }

    public String getTentruyen() { return tentruyen; }
    public void setTentruyen(String tentruyen) { this.tentruyen = tentruyen; }

    public String getMota() { return mota; }
    public void setMota(String mota) { this.mota = mota; }

    public String getTrangthai() { return trangthai; }
    public void setTrangthai(String trangthai) { this.trangthai = trangthai; }

    public String getAnhbia() { return anhbia; }
    public void setAnhbia(String anhbia) { this.anhbia = anhbia; }

    public Integer getLuotxem() { return luotxem; }
    public void setLuotxem(Integer luotxem) { this.luotxem = luotxem; }

    public String getTheloaiids() { return theloaiids; }
    public void setTheloaiids(String theloaiids) { this.theloaiids = theloaiids; }
}