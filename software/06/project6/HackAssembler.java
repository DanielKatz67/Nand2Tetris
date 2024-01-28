import java.io.*;
import java.io.BufferedWriter;
import java.io.FileWriter;

public class HackAssembler {
    private Parser firstLoop;
    private Parser secondLoop;
    private File file;

    public HackAssembler(File file) throws IOException {
        firstLoop  = new Parser(file);
        secondLoop = new Parser(file);
        this.file=file;
    }

    /**
     *Are there more lines in the input?
     */
    public void translateToHack()  {
        try {
            SymbolTable symbolTable = new SymbolTable();

            // first pass: adding (label) to the symbol table
            int lineCounter=0;
            while (firstLoop.hasMoreLines()) {
                firstLoop.advance();
                if (firstLoop.instructionType() == "L_INSTRUCTION") {
                    symbolTable.addEntry(firstLoop.symbol(),lineCounter);
                }
                else {
                    // L_INSTRUCTION lines dont need to be counted
                    lineCounter++;
                }
            }

            // creating the output file
            String fileNameWithoutEnding;
            int lastSlashIndex = file.getName().lastIndexOf("/");
            int dotIndex = file.getName().lastIndexOf(".asm");

            if (lastSlashIndex != -1 && dotIndex != -1)
                fileNameWithoutEnding = file.getName().substring(lastSlashIndex + 1, dotIndex);
            else if (lastSlashIndex == -1 && dotIndex != -1)
                fileNameWithoutEnding = file.getName().substring(0,dotIndex);
            else
                fileNameWithoutEnding="";


            File output_file = new File(fileNameWithoutEnding+".hack");
            BufferedWriter writer = new BufferedWriter(new FileWriter(output_file,false));

            // second pass: main loop
            int symbolAddress = 0;
            //indicares if it is required to call newLine()
            boolean emptyOutputFile=true;

            while (secondLoop.hasMoreLines()) {
                secondLoop.advance();
                String symbol = secondLoop.symbol();
                if (secondLoop.instructionType() == "A_INSTRUCTION") {
                    // check if the address is a direct number or a symbol
                    try {
                        symbolAddress=Integer.parseInt(symbol);
                    } catch (NumberFormatException e) {
                        if (!symbolTable.contains(symbol)) {
                            symbolTable.addEntry(symbol,symbolTable.newAddress);
                            symbolTable.newAddress++;
                        }
                        symbolAddress = symbolTable.getAddress(symbol);
                    }

                    if(!emptyOutputFile) writer.newLine();
                    emptyOutputFile = false;

                    // converting the address to 16-bits string, and write it
                    writer.write(String.format("%16s",
                                    Integer.toBinaryString(symbolAddress))
                            .replace(' ', '0'));

//                    System.out.println(String.format("%16s",
//                                    Integer.toBinaryString(symbolAddress))
//                            .replace(' ', '0'));
                }

                if (secondLoop.instructionType() == "C_INSTRUCTION"){
                    String dest = secondLoop.dest();
                    String comp = secondLoop.comp();
                    String jump = secondLoop.jump();
                    String a = (comp.contains("M")) ? "1" : "0" ;

                    if(!emptyOutputFile) writer.newLine();
                    emptyOutputFile = false;

                    writer.write("111" +a + Code.comp(comp) +
                            Code.dest(dest) +
                            Code.jump(jump));

//                    System.out.println("111" +a + Code.comp(comp) +
//                            Code.dest(dest) +
//                            Code.jump(jump));
                }
            }
            writer.close();
        } catch (
                IOException e) {
            e.printStackTrace();
        }
    }
}
