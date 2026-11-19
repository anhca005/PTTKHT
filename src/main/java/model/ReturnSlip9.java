package model;

import java.util.Date;
import java.util.ArrayList;

public class ReturnSlip9 implements java.io.Serializable {
    private int id;
    private Date returnDate;
    private float totalFine;
    private String note;
    private Librarian9 librarian;
    private ArrayList<BorrowedDocument9> borrowedDocuments;

    public ReturnSlip9() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public float getTotalFine() {
        return totalFine;
    }

    public void setTotalFine(float totalFine) {
        this.totalFine = totalFine;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Librarian9 getLibrarian() {
        return librarian;
    }

    public void setLibrarian(Librarian9 librarian) {
        this.librarian = librarian;
    }

    public ArrayList<BorrowedDocument9> getBorrowedDocuments() {
        return borrowedDocuments;
    }

    public void setBorrowedDocuments(ArrayList<BorrowedDocument9> borrowedDocuments) {
        this.borrowedDocuments = borrowedDocuments;
    }
}
