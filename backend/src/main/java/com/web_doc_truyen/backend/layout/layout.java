package com.web_doc_truyen.backend.layout;


import jakarta.persistence.*;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Entity
@Table(name = "layout")
public class layout {
      @Id
      @GeneratedValue(strategy = GenerationType.IDENTITY)
      private Integer id;

      @Column(name = "ten_theloai" ,unique = true,nullable = false)
      private String ten_theloai;

      public String getTen_theloai() {
            return ten_theloai;
      }

      public void setTen_theloai(String ten_theloai) {
            this.ten_theloai = ten_theloai;
      }

      public Integer getId() {
            return id;
      }

      public void setId(Integer id) {
            this.id = id;
      }
}
