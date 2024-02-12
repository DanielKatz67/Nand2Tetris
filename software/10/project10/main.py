import os
import glob
import sys
import CompilationEngine

def main(input_path):
    if os.path.isfile(input_path) and input_path.endswith('.jack'):
        translate_single_file_jack_to_xml(input_path)

    elif os.path.isdir(input_path) :
        jack_files = glob.glob(os.path.join(input_path, '*.jack'))
        # Ensure the path ends with '/' to correctly calculate the directory name
        if not input_path.endswith('/'): input_path += '/'
        # Determine the name of the output .asm file
        for jack_file in jack_files:
            translate_single_file_jack_to_xml(jack_file)

def translate_single_file_jack_to_xml(jack_file):
    output_path = jack_file.split('.')[0]+'.xml'
    engine = CompilationEngine.CompilationEngine(jack_file, output_path)
    engine.compileClass()
    engine.remove_last_newline()

if __name__ == '__main__':
    # dir_path = '/Users/daniel/Desktop/Nand2Tetris/projects/software/10/ArrayTest/Main.jack'
    # dir_path = '/Users/daniel/Desktop/Nand2Tetris/projects/software/10/Square'
    # dir_path = '/Users/daniel/Desktop/Nand2Tetris/projects/software/10/ExpressionLessSquare'
    # dir_path = '/Users/daniel/Desktop/Nand2Tetris/projects/software/10/Square/Square.jack'
    # dir_path = '/Users/daniel/Desktop/10tests/tests'

    if len(sys.argv) != 2:
        print("Usage: JackAnalyzer <directory path>")
        sys.exit(1)

    dir_path = sys.argv[1]
    main(dir_path)