package model;

public class BorrowedDocument9 implements java.io.Serializable {
    private int id;
    private String status;
    private float fine;
    private Document9 document;

    public BorrowedDocument9() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public float getFine() {
        return fine;
    }

    public void setFine(float fine) {
        this.fine = fine;
    }

    public Document9 getDocument() {
        return document;
    }

    public void setDocument(Document9 document) {
        this.document = document;
    }
}
