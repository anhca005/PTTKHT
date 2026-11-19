package model;

import java.util.Date;
import java.util.ArrayList;

public class BorrowSlip9 implements java.io.Serializable {
    private int id;
    private Date borrowDate;
    private Date dueDate;
    private String note;
    private ReaderCard9 readerCard;
    private Librarian9 librarian;
    private ArrayList<BorrowedDocument9> borrowedDocuments;

    public BorrowSlip9() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public ReaderCard9 getReaderCard() {
        return readerCard;
    }

    public void setReaderCard(ReaderCard9 readerCard) {
        this.readerCard = readerCard;
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
