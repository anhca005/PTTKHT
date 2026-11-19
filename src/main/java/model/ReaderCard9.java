package model;

import java.util.Date;

public class ReaderCard9 implements java.io.Serializable {
    private int id;
    private String cardCode;
    private Date issueDate;
    private Date expiryDate;
    private String status;
    private Reader9 reader;

    public ReaderCard9() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCardCode() {
        return cardCode;
    }

    public void setCardCode(String cardCode) {
        this.cardCode = cardCode;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Reader9 getReader() {
        return reader;
    }

    public void setReader(Reader9 reader) {
        this.reader = reader;
    }
}
