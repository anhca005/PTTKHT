package model;

public class ReaderStat9 extends Reader9 {
    private int borrowCount;

    public ReaderStat9() {
        super();
    }

    public int getBorrowCount() {
        return borrowCount;
    }

    public void setBorrowCount(int borrowCount) {
        this.borrowCount = borrowCount;
    }
}
