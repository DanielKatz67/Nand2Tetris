import java.io.File;
import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException {

        //File file = new File(args[0]);
//        File file = new File("/Users/daniel/Desktop/Nand2Tetris/projects/06/add/Add.asm");
//        HackAssembler HA = new HackAssembler(file);
//        HA.translateToHack();

        if (args.length != 1) {
            System.err.println("Usage: Assembler <path to .asm file or directory>");
            System.exit(1);
        }

        File input = new File(args[0]);

        if (input.isDirectory()) {
            // Process all .asm files in the directory
            File[] files = input.listFiles((dir, name) -> name.endsWith(".asm"));
            if (files != null) {
                for (int i = 0; i < files.length; i++) {
                    HackAssembler HA = new HackAssembler(files[i]);
                    HA.translateToHack();
                }
            }
        } else if (input.isFile() && input.getName().endsWith(".asm")) {
            // Process a single .asm file
            HackAssembler HA = new HackAssembler(input);
            HA.translateToHack();
        } else {
            System.err.println("Invalid input. Please provide a .asm file or a directory containing .asm files.");
            System.exit(1);
        }
    }
}
