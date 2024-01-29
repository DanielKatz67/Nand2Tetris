import os
import glob
import sys
import Parser
import CodeWriter

def main(input_path):
    PATH=input_path

    if os.path.isfile(PATH) and PATH.endswith('.vm'):
        output_file = PATH.split('.')[0]+'.asm'
        writer = CodeWriter.CodeWriter(output_file)
        writer.set_SP_to_256()
        translate_single_file_vm_to_asm(PATH, writer)
        writer.close()

    if os.path.isdir(PATH) :
        vm_files = glob.glob(os.path.join(PATH, '*.vm'))
        # Ensure the path ends with '/' to correctly calculate the directory name
        if not PATH.endswith('/'): PATH += '/'
        # Determine the name of the output .asm file
        dir_name = os.path.basename(os.path.normpath(PATH))
        output_file = os.path.join(PATH, dir_name + '.asm')
        writer = CodeWriter.CodeWriter(output_file)
        writer.set_SP_to_256()

        for vm_file in vm_files:
            writer.write_vm_file_name_comment(vm_file)
            translate_single_file_vm_to_asm(vm_file, writer)
        writer.close()

def translate_single_file_vm_to_asm(inputFile, writer):
    parser = Parser.Parser(inputFile)
    while parser.hasMoreLines() :
        parser.advance()
        writer.write_vm_line_as_comment(parser.current_line)
        commandType = parser.commandType()
        arg1 = ''
        arg2 = ''
        if commandType != 'C_RETURN' :
            arg1 = parser.arg1()
        if commandType in ['C_PUSH', 'C_POP', 'C_FUNCTION', 'C_CALL']:
            arg2 = parser.arg2()

        if commandType == 'C_ARITHMETIC':
            writer.writeArithmetic(arg1)

        if commandType in ['C_PUSH', 'C_POP']:
            writer.writePushPop(commandType, arg1, int(arg2))


    parser.close()

if __name__ == '__main__':
    # dir_path = '/Users/daniel/Desktop/Nand2Tetris/projects/software/07/MemoryAccess/PointerTest/PointerTest.vm'
    # dir_path = '/Users/daniel/Desktop/Nand2Tetris/projects/software/07/MemoryAccess/PointerTest/testPointe.vm'
    if len(sys.argv) != 2:
        print("Usage: VMtranslator <directory path>")
        sys.exit(1)

    dir_path = sys.argv[1]
    main(dir_path)

