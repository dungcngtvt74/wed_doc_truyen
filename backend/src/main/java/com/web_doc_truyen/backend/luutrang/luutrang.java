package com.web_doc_truyen.backend.luutrang;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "luu_trang_doc")
@IdClass(luutrang.LuutrangId.class)
public class luutrang {


    public static class LuutrangId implements Serializable {
        private Integer idnguoidung;
        private Integer idtruyen;

        public LuutrangId() {}

        public Integer getIdnguoidung() { return idnguoidung; }
        public void setIdnguoidung(Integer idnguoidung) { this.idnguoidung = idnguoidung; }

        public Integer getIdtruyen() { return idtruyen; }
        public void setIdtruyen(Integer idtruyen) { this.idtruyen = idtruyen; }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            LuutrangId that = (LuutrangId) o;
            return Objects.equals(idnguoidung, that.idnguoidung) &&
                    Objects.equals(idtruyen, that.idtruyen);
        }

        @Override
        public int hashCode() {
            return Objects.hash(idnguoidung, idtruyen);
        }
    }

    @Id
    @Column(name = "id_nguoidung")
    private Integer idnguoidung;

    @Id
    @Column(name = "id_truyen")
    private Integer idtruyen;

    @Column(name = "id_chuong", nullable = false)
    private Integer idchuong;

    @Column(name = "so_trang", nullable = false)
    private Integer sotrang;

    @Column(name = "ngay_cap_nhat")
    private LocalDateTime ngaycapnhat;


    public Integer getIdnguoidung() { return idnguoidung; }
    public void setIdnguoidung(Integer idnguoidung) { this.idnguoidung = idnguoidung; }

    public Integer getIdtruyen() { return idtruyen; }
    public void setIdtruyen(Integer idtruyen) { this.idtruyen = idtruyen; }

    public Integer getIdchuong() { return idchuong; }
    public void setIdchuong(Integer idchuong) { this.idchuong = idchuong; }

    public Integer getSotrang() { return sotrang; }
    public void setSotrang(Integer sotrang) { this.sotrang = sotrang; }

    public LocalDateTime getNgaycapnhat() { return ngaycapnhat; }
    public void setNgaycapnhat(LocalDateTime ngaycapnhat) { this.ngaycapnhat = ngaycapnhat; }
}