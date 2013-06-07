/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.dataControllers;

import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.print.PageFormat;
import java.awt.print.Paper;
import java.awt.print.Printable;
import java.awt.print.PrinterException;
import java.awt.print.PrinterJob;
import java.util.Vector;
import javax.print.PrintService;

/**
 *
 * @author vic
 */
public class PrinterController implements Printable {

    private boolean chefDoc = false;
    private Order o;
    private static String fontName = "DejaVu Sans Mono";
    private static final int CHEFPAGE_FONT_SIZE = 10;
    private static final int RECEIPT_FONT_SIZE = 7;
    private int[] pageBreaks;
    private int pageI = 0;
    private String[] doc = null;

    //printing operations
    private int computeLineHeight(Graphics g) {
        int size = (chefDoc) ? CHEFPAGE_FONT_SIZE : RECEIPT_FONT_SIZE;
        Font font = new Font(fontName, Font.PLAIN, size);
        FontMetrics metrics = g.getFontMetrics(font);

        return metrics.getHeight();
    }

    private void computePageBreaks(int lineHeight, double pageHeight, int docSize) {
        int linesPerPage = ((int) pageHeight) / lineHeight;
        int numBreaks = (docSize) / linesPerPage;
        int size = numBreaks;
        if (docSize % linesPerPage > 0 | docSize < linesPerPage) {
            size++;
        }
        pageBreaks = new int[size];
        for (int b = 0; b < numBreaks; b++) {
            pageBreaks[b] = (b + 1) * linesPerPage;
        }
        if (size > numBreaks) {
            pageBreaks[size - 1] = docSize;
        }
    }

    public boolean isChefDoc() {
        return chefDoc;
    }

    public Order getOrder() {
        return o;
    }

    public void setChefDoc(boolean isChefDoc) {
        this.chefDoc = isChefDoc;
    }

    public void setOrder(Order o) {
        this.o = o;
    }

    class Line {

        public StringBuilder line;
        //width is the number of characters in the stringbuilder.
        private int width = 0;

        public Line(int w) {
            width = w;
            line = new StringBuilder(w);
            fillWithSpaces();
        }

        public Line() {
            width = 0;
            line = new StringBuilder();
        }

        public void fillWithSpaces() {
            char space = ' ';
            for (int i = 0; i < width; i++) {
                line.append(space);
            }
        }

        public int getWidth() {
            return width;
        }

        public void setWidth(int width) {
            this.width = width;
        }
    }

    //represent a continuos page
    class Pagedoc {

        protected Vector<Line> page = new Vector<Line>();
        private String[] text;
        //width is the number of chars in the line and height is the number of lines in a page.
        private int width = 0;
        private Order o;

        public Pagedoc(int w, Order newOrder) {
            width = w;
            o = newOrder;
        }

        public Pagedoc(int w) {
            this(w, null);
        }

        public Pagedoc() {
        }

        public void create(int w, Order newOrder) {
            width = w;
            o = newOrder;
        }

        public int getWidth() {
            return width;
        }

        public Order getOrder() {
            return o;
        }

        public void setOrder(Order o) {
            this.o = o;
        }

        private void setupText() {
            text = new String[page.size()];
            for (int i = 0; i < text.length; i++) {
                text[i] = page.get(i).line.toString();
            }
        }

        public String[] getPage() {
            if (text == null) {
                setupText();
            }
            return text;
        }
    }

    class ChefPage extends Pagedoc {

        private int pageNumber = 1;
        private Font font = new Font(PrinterController.fontName, Font.PLAIN, PrinterController.CHEFPAGE_FONT_SIZE);

        public ChefPage(double w, Order o) {
            super();
            super.create(getLineWidth(w), o);
            this.writePage();
        }

        public ChefPage(double w) {
            this(w, null);
        }

        //private operations{
        private int getLineWidth(double pageWidth) {
            int widthPerChar = font.getSize() / 2;
            return (((int) Math.round(pageWidth)) / widthPerChar) + 3;
        }

        private String[] formatLines(String s, int width) {
            if (s.compareTo("") == 0) {
                return null;
            }
            int size = s.length();
            int numOfLines = size / width;
            int lenght = numOfLines;
            if (size > width) {
                if (size % width > 0) {
                    lenght++;
                }
                String[] re = new String[lenght];
                int initial = 0;
                int finall = width;
                for (int i = 0; i < numOfLines; i++) {
                    String temp = s.substring(initial, finall);
                    re[i] = temp;
                    initial = finall;
                    finall += finall;
                }
                if (size % width > 0) {
                    finall = size % width + initial;
                    String temp = s.substring(initial, finall);
                    re[lenght - 1] = temp;
                }
                return re;
            }
            String[] r = new String[1];
            r[0] = s;
            return r;
        }

        private void writeCusLines(String text) {
            String[] lines = formatLines(text, this.getWidth());
            for (int i = 0; i < lines.length; i++) {
                Line l = new Line(this.getWidth());
                l.line.replace(0, lines[i].length(), lines[i]);
                page.add(l);
            }
        }

        private void writeProductItems(int i, int columns) {
            Item item = this.getOrder().getItem(i);

            String index = Integer.toString(i + 1);
            String[] productName = formatLines(item.getModel().getProduct(), columns);
            String[] productDetail = formatLines(item.getModel().getProductDetail(), columns);
            String q = Integer.toString(item.getQuantity());
            //fill the first line
            String productDetailT = (productDetail != null) ? productDetail[0] : "";
            String sp = " ";
            StringBuilder t0 = new StringBuilder(index + "  " + q + "  " + productName[0]);
            for (int j = 0; j < (columns - productName[0].length()); j++) {
                t0.append(sp);
            }
            String firstLine = t0.toString() + productDetailT;
            Line s = new Line(this.getWidth());
            s.line.replace(0, firstLine.length(), firstLine);
            page.add(s);

            //calculate mayor and minor
            String[] mayor;
            String[] minor;
            int colMayor;
            int colMinor;
            if ((productDetail == null) || (productName.length >= productDetail.length)) {
                mayor = productName;
                minor = productDetail;
                colMayor = 6;
                colMinor = 6 + columns-1;
            } else {
                mayor = productDetail;
                minor = productName;
                colMayor = 7 + columns-1;
                colMinor = 7;
            }
            int j = 0;
            if (minor != null) {
                for (j = 1; j < minor.length; j++) {
                    Line l = new Line(this.getWidth());
                    StringBuilder line = l.line;
                    line.replace(colMayor, colMayor + mayor[j].length(), mayor[j]);
                    line.replace(colMinor, colMinor + minor[j].length(), minor[j]);
                    page.add(l);
                }
            }
            int dif = (minor != null) ? mayor.length - minor.length + 1 : mayor.length;
            for (int j1 = 1; j1 < dif; j1++) {
                Line l = new Line(this.getWidth());
                StringBuilder line = l.line;
                line.replace(colMayor, colMayor + mayor[j - 1 + j1].length(), mayor[j - 1 + j1]);
                page.add(l);
            }
        }

        private void insertALine() {
            Line l = new Line(this.getWidth());
            page.add(l);
        }
        //}
        //getters and setters{

        public Font getFont() {
            return font;
        }

        public int getPageNumber() {
            return pageNumber;
        }

        public void setPageNumber(int pageNumber) {
            this.pageNumber = pageNumber;
        }
        //}
        //page builder operations{

        public void writePage() {
            if (this.getOrder() != null) {
                writePageNumber();
                insertALine();
                writeOrderID();
                insertALine();
                writeCus();
                writeProducts();
            } else {
                System.out.println("The order has not been set.");
            }
        }

        private void writePageNumber() {
            int pos = this.getWidth() - 4;
            Line l = new Line(this.getWidth());
            l.line.setCharAt(pos, Integer.toString(pageNumber).charAt(0));
            page.add(l);
        }

        private void writeOrderID() {
            String text = "Order #:".concat(Integer.toString(this.getOrder().getOrderID()));
            Line l = new Line(this.getWidth());
            StringBuilder li = l.line;
            li.replace(0, text.length(), text);
            page.add(l);
        }

        private void writeCus() {
            String[] texts = {"Name:".concat(this.getOrder().getCustomer().getName()), "Address:".concat(this.getOrder().getCustomer().getAddress()),
                "Telephone:".concat(Integer.toString(this.getOrder().getCustomer().getTelephone()))};
            for (int i = 0; i < 3; i++) {
                writeCusLines(texts[i]);
            }
        }

        private void writeProducts() {
            //write the product Title
            insertALine();
            String text0 = "Products";
            Line l = new Line(this.getWidth());
            StringBuilder li = l.line;
            li.replace(0, text0.length(), text0);
            page.add(l);

            //write the columns
            StringBuilder text1 = new StringBuilder("   Qt Product Name  ");
            StringBuilder text2 = new StringBuilder("Product Detail");

            int space = (this.getWidth() - text1.length() - text2.length()) / 2;
            String sp = " ";
            for (int i = 0; i < space-13; i++) {
                text1.append(sp);
                text2.append(sp);
            }
            String text3 = text1.toString() + text2.toString();
            Line l1 = new Line(this.getWidth());
            StringBuilder li1 = l1.line;
            li1.replace(0, text3.length(), text3);
            page.add(l1);
            insertALine();

            int size = this.getOrder().getItems().length;
            for (int j = 0; j < size; j++) {
                writeProductItems(j, space+1);
            }
        }
        //}
    }

    class ReceiptPage extends Pagedoc {

        private Font font = new Font(PrinterController.fontName, Font.PLAIN, PrinterController.RECEIPT_FONT_SIZE);

        public ReceiptPage(double w, Order o) {
            super();
            super.create(getLineWidth(w), o);
            this.writePage();
        }

        public ReceiptPage(double w) {
            this(w, null);
        }

        //private operations{
        private int getLineWidth(double pageWidth) {
            int widthPerChar = font.getSize() / 2;
            return (((int) Math.round(pageWidth)) / widthPerChar);
        }

        private String[] formatLines(String s, int width) {
            if (s.compareTo("") == 0) {
                return null;
            }
            int size = s.length();
            int numOfLines = size / width;
            int lenght = numOfLines;
            if (size > width) {
                if (size % width > 0) {
                    lenght++;
                }
                String[] re = new String[lenght];
                int initial = 0;
                int finall = width;
                for (int i = 0; i < numOfLines; i++) {
                    String temp = s.substring(initial, finall);
                    re[i] = temp;
                    initial = finall;
                    finall += finall;
                }
                if (size % width > 0) {
                    finall = size % width + initial;
                    String temp = s.substring(initial, finall);
                    re[lenght - 1] = temp;
                }
                return re;
            }
            String[] r = new String[1];
            r[0] = s;
            return r;
        }

        private void insertALine() {
            Line l = new Line(this.getWidth());
            page.add(l);
        }

        private String formatLineCenter(String s, int w) {
            int dif = w - s.length();
            if (dif > 0) {
                String sp = " ";
                StringBuilder c = new StringBuilder(s);
                for (int i = 0; i < dif / 2; i++) {
                    c.insert(0, sp);
                }
                return c.toString();
            }
            return s;
        }

        private String formatQuantities(double n) {
            int n1 = (int) (Math.round(n * 100));
            int m=n1/100;
            double d = n1 % 100;
            double d1 = d / 100;
            return Double.toString(m + d1);
        }

        private void writeCusLines(String text) {
            String[] lines = formatLines(text, this.getWidth());
            for (int i = 0; i < lines.length; i++) {
                Line l = new Line(this.getWidth());
                l.line.replace(0, lines[i].length(), lines[i]);
                page.add(l);
            }
        }
         private void writeOrderID() {
            String text = "Order #:".concat(Integer.toString(this.getOrder().getOrderID()));
            Line l = new Line(this.getWidth());
            StringBuilder li = l.line;
            li.replace(0, text.length(), text);
            page.add(l);
            insertALine();
        }

        private void writeProductItems(int i, int columns) {
            Item item = this.getOrder().getItem(i);
            if(item.getPrice()!=0){
                String[] productName = formatLines(item.getModel().getProduct(), columns);
                String q = Integer.toString(item.getQuantity());

                //fill the first line
                String firstLine = q + " " + productName[0]+"...$"+formatQuantities(item.getPrice());
                Line l = new Line(this.getWidth());
                l.line.replace(0, firstLine.length(), firstLine);
                page.add(l);

                for (int j = 1; j < productName.length; j++) {
                    Line li = new Line(this.getWidth());
                    StringBuilder line = li.line;
                    line.replace(4, 4 + productName[j].length(), productName[j]);
                    page.add(li);
                }
            }
        }
        //page builder operations{

        public void writePage() {
            if (this.getOrder() != null) {
                writeTitle();
                writeOrderID();
                if (!this.getOrder().isNullCustomer()) {
                    writeCus();
                }
                writeProducts();
                writeTotals();
            } else {
                System.out.println("The order has not been set.");
            }
        }

        private void writeTitle() {
            String[] textvals = {"A. Hamilton Cafe", "A Taste of Silk City",
                "29 church st,Paterson,NJ 07505", "Tel:973-653-3866,Fax:973-684-0194"};
            for (int i = 0; i < 4; i++) {
                Line li = new Line(this.getWidth());
                StringBuilder l = li.line;
                String text = formatLineCenter(textvals[i], this.getWidth()-12);
                l.replace(0, text.length(), text);
                page.add(li);
            }
            insertALine();
        }

        private void writeCus() {
            String[] texts = {"Name:".concat(this.getOrder().getCustomer().getName()), "Address:".concat(this.getOrder().getCustomer().getAddress()),
                "Telephone:".concat(Integer.toString(this.getOrder().getCustomer().getTelephone()))};
            for (int i = 0; i < 3; i++) {
                writeCusLines(texts[i]);
            }
            this.insertALine();
        }

        private void writeProducts() {
            //add the column titles
            StringBuilder text0 = new StringBuilder("Qt Products");
            int space = Math.round(this.getWidth() - text0.length());
            char sp = ' ';
            for (int i = 0; i < space; i++) {
                text0.append(sp);
            }
            Line l = new Line(this.getWidth());
            l.line.replace(0, text0.toString().length(), text0.toString());
            page.add(l);
            insertALine();

            //add the products
            int size = this.getOrder().getItems().length;
            int columns = space;
            for (int j = 0; j < size; j++) {
                writeProductItems(j, columns);
            }
            insertALine();
        }

        private void writeTotals() {
            double total = this.getOrder().getTotal();
            double subtotal = this.getOrder().getSubTotal();
            double tax = this.getOrder().getUntaxedItemTotal();
            String[] texts = {"SubTotal:.......$" + formatQuantities(subtotal), "Taxes:..........$" + formatQuantities(tax), "   Total:.......$" + formatQuantities(total)};
            for (int i = 0; i < 3; i++) {
                Line li = new Line(this.getWidth());
                StringBuilder l = li.line;
                l.replace(0, texts[i].length(), texts[i]);
                page.add(li);
            }
            insertALine();
            Line li = new Line(this.getWidth());
            StringBuilder l = li.line;
            l.replace(0, 1, ".");
            page.add(li);
        }
    }

    @Override
    public int print(Graphics g, PageFormat pf, int pageIndex) throws PrinterException {
        int lineHeight = computeLineHeight(g);

        if (pageI == 0) {
            double pageHeight = pf.getImageableHeight();
            double pageWidth = pf.getImageableWidth();
            if (chefDoc) {
                ChefPage c = new ChefPage(pageWidth, o);
                doc = c.getPage();
            } else {
                ReceiptPage c = new ReceiptPage(pageWidth, o);
                doc = c.getPage();
            }
            computePageBreaks(lineHeight, pageHeight, doc.length);
        }
        if (pageIndex >= pageBreaks.length) {
            return NO_SUCH_PAGE;
        }

        Graphics2D g2d = (Graphics2D) g;
        g2d.translate(pf.getImageableX(), pf.getImageableY());
        Font f=(chefDoc) ? new Font(fontName,Font.PLAIN,CHEFPAGE_FONT_SIZE) : new Font(fontName,Font.PLAIN,RECEIPT_FONT_SIZE);
        g.setFont(f);
        //paint g
        int y = 0;
        int start = (pageIndex == 0) ? 0 : pageBreaks[pageIndex - 1];
        int end = pageBreaks[pageIndex];
        for (int line = start; line < end; line++) {
            y += lineHeight;
            g.drawString(doc[line], 0, y);
        }

        pageI++;
        return PAGE_EXISTS;
    }
    //main method

    public void printDoc() {
        if (o == null) {
            System.out.println("There is no order set to print out.");
        } 
        else {
            PrintService[] services =PrinterJob.lookupPrintServices();
            PrinterJob job = PrinterJob.getPrinterJob();

            Paper p=new Paper();
            p.setSize(200, 600);
            p.setImageableArea(0, 0, 200, 600);
            PageFormat pfo=new PageFormat();
            pfo.setPaper(p);
           
            if(services.length>=2){
                try {
                    //customer decide to use only the receipt page
                    job.setPrintable(this, pfo);
                    job.setPrintService(services[0]);
                    job.print();
                }
                catch (PrinterException ex) {
                    System.out.println("The job did not successfully complete");
                }
            }
        }
    }
}
