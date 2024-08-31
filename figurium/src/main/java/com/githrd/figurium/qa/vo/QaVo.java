package com.githrd.figurium.qa.vo;

import java.time.LocalDateTime;

public class QaVo {

    private int id;           // Q&A 게시물 IDX
    private int productId;    // 상품 ID
    private int userId;       // 사용자 ID
    private String title;     // 질문 제목
    private String content;   // 질문 내용
    private String reply;     // 질문 답글
    private LocalDateTime created;     // 작성일자
    private LocalDateTime updated;     // 수정일자

    // 기본 생성자
    public QaVo() {}

    // 모든 필드를 포함한 생성자
    public QaVo(int id, int productId, int userId, String title, String content, String reply, LocalDateTime created, LocalDateTime updated) {
        this.id = id;
        this.productId = productId;
        this.userId = userId;
        this.title = title;
        this.content = content;
        this.reply = reply;
        this.created = created;
        this.updated = updated;
    }

    // Getter 및 Setter 메서드
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

    public LocalDateTime getCreated() {
        return created;
    }

    public void setCreated(LocalDateTime created) {
        this.created = created;
    }

    public LocalDateTime getUpdated() {
        return updated;
    }

    public void setUpdated(LocalDateTime updated) {
        this.updated = updated;
    }

    @Override
    public String toString() {
        return "QAVo{" +
                "id=" + id +
                ", productId=" + productId +
                ", userId=" + userId +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", reply='" + reply + '\'' +
                ", created=" + created +
                ", updated=" + updated +
                '}';
    }
}