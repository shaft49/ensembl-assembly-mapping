import argparse
from converter import Converter
from printer import Printer
class AssemblyMapping():
    def __init__(self):
        pass
    
    def define_arguments(self):
        parser = argparse.ArgumentParser()
        parser.add_argument('-s', '--species', default = 'human', help = 'Species name/alias, default value is human')
        parser.add_argument('-a1', '--asm_one', default = 'GRCh38', help = 'Version of the input assembly, default value is GRCh38')
        parser.add_argument('-a2', '--asm_two', default = 'GRCh37', help = 'Version of the output assembly, default value is GRCh37')
        parser.add_argument('-c', '--chromosome', required = True, help = 'Name of the chromosome [1-22] X Y.')
        parser.add_argument('-st', '--start', required = True, help = 'Start point for that chromosome.')
        parser.add_argument('-en', '--end', required = True, help = 'End point for that chromosome.')
        parser.add_argument('-f', '--file_name', default='data.json', help = 'Dumps Json data in the given given file, default file_name is data.json')
        parser.add_argument('-str', '--strand', default='', help = '-1, 1 or empty, default value is empty.')
        return parser
    
    def assembly_mappping(self):
        parser = self.define_arguments()
        args = parser.parse_args()
        print('[INFO] This script will run with the following value')
        print(f'species: {args.species}, asm_one: {args.asm_one}, asm_two: {args.asm_two}, chromosome: {args.chromosome} start: {args.start}, end: {args.end}, file_name: {args.file_name}, strand: {args.strand}\n')
        converter = Converter(args.species, args.asm_one, args.asm_two, args.chromosome, args.start, args.end, args.strand)
        data = converter.convert()
        if data is not None:
            printer = Printer(args.file_name)
            printer.dump_json_data(data)
            print(f'Showing Assembly Mapping from {args.asm_one} to {args.asm_two} for chromosome {args.chromosome} between {args.start} and {args.end}')
            printer.show_data_mappings(data)

if __name__ == '__main__':
    print('[INFO] Start of script.')
    mapping = AssemblyMapping()
    mapping.assembly_mappping()
    print('[INFO] End of script.')