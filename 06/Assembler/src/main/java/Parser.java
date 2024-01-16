//package ...;
import java.io.*;

public class Parser {
    private BufferedReader bufferFile;
    private String currentLine;

    /**
     *Opens the input file/stream and gets ready to parse it.
     *Arguments: Input file or stream
     */
    public Parser(File file) throws IOException {
        Reader reader = new FileReader(file);
        bufferFile = new BufferedReader(reader);
        currentLine = null;
    }

    /**
     *Are there more lines in the input?
     */
    public boolean hasMoreLines() throws IOException {
        currentLine=bufferFile.readLine();
        return currentLine != null;
    }

    /**
     *Skips over whitespace and comments, if necessary.
     * Reads the next instruction from the input, and makes it the current instruction.
     * This method should be called only if hasMoreLines is true.
     * Initially there is no current instruction
     */
    public void advance () throws IOException{
        // Assuming currentLine already contains the next line from hasMoreLines
        // Trim the current line to remove leading and trailing whitespace
        currentLine = currentLine.trim();

        // If the line is a comment or empty, keep reading the next line
        while (currentLine.isEmpty()) {
            currentLine = bufferFile.readLine();
            if (currentLine == null) { // End of file reached
                break;
            }
            currentLine = currentLine.trim();
        }
    }

    /**
     *Returns the type of the current instruction:
     * A_INSTRUCTION for @xxx,where xxx is either a decimal number or a symbol.
     * (constants) C_INSTRUCTION for dest=comp; jump
     * L_INSTRUCTION for (xxx), where xxx is a symbol.
     */
    public String instructionType (){
        if (currentLine.startsWith("@")) {
            return "A_INSTRUCTION";
        } else if (currentLine.startsWith("(") && currentLine.endsWith(")")) {
            return "L_INSTRUCTION";
        } else {
            return "C_INSTRUCTION";
        }
    }

    /**
     *If the current instruction is (xxx), returns the symbol xxx.
     *If the current instruction is @xxx, returns the symbol or decimal xxx (as a string).
     * Should be called only if instructionType is A_INSTRUCTION or L_INSTRUCTION.
     */
    public String symbol (){
        if (currentLine.startsWith("@")) {
            return currentLine.substring(1);
        }
        // Assuming the method called only for A_INSTRUCTION or L_INSTRUCTION
        // L_INSTRUCTION : (XXXX) so I want to return substring(1,5)=substring(1,length-1). the length is 6
        else return currentLine.substring(1,currentLine.length()-1);
    }

    /**
     *Returns the symbolic dest part of the current C-instruction (8 possibilities).
     *Should be called only if instructionType is C_INSTRUCTION.
     */
    public String dest (){
        int posFirstSep = currentLine.indexOf('=');
        // dest does not exist
        if(posFirstSep == -1)
            return null;
        // there is a dest part
        return currentLine.substring(0, posFirstSep);
    }

    /**
     *Returns the symbolic comp part of the current C-instruction (28 possibilities).
     *Should be called only if instructionType is C_INSTRUCTION.
     */
    public String comp (){
        int posFirstSep = currentLine.indexOf('=');
        int posSecondSep = currentLine.indexOf(';');

        // dest does not exist so comp must be first
        if(posFirstSep == -1)
            return  currentLine.substring(0, posSecondSep);

        // dest exists and jump does not
        if (posSecondSep == -1)
            return  currentLine.substring(posFirstSep+1 );

        // dest exists and jump exists
        return  currentLine.substring(posFirstSep+1 , posSecondSep);
    }

    /**
     *Returns the symbolic jump part of the current C-instruction (8 possibilities).
     *Should be called only if instructionType is C_INSTRUCTION.
     */
    public String jump (){
        int posSecondSep = currentLine.indexOf(';');
        // jump does not exist
        if(posSecondSep == -1)
            return null;
        // there is a jump part
        return currentLine.substring(posSecondSep+1);
    }

}
