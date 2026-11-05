package com.web_doc_truyen.backend.tacgia;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;

@Entity
@Table(name = "tacgia")
public class tacgia {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @JsonProperty("ten_tacgia")
    @Column(name = "ten_tacgia", unique = true, nullable = false)
    private String tenTacGia;

    @JsonProperty("but_danh")
    @Column(name = "but_danh")
    private String butDanh;

    @JsonProperty("gioi_thieu")
    @Column(name = "gioi_thieu", columnDefinition = "TEXT")
    private String gioiThieu;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getTenTacGia() { return tenTacGia; }
    public void setTenTacGia(String tenTacGia) { this.tenTacGia = tenTacGia; }

    public String getButDanh() { return butDanh; }
    public void setButDanh(String butDanh) { this.butDanh = butDanh; }

    public String getGioiThieu() { return gioiThieu; }
    public void setGioiThieu(String gioiThieu) { this.gioiThieu = gioiThieu; }
}