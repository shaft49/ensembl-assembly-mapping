import argparse
import requests
import json
class Converter:
    def __init__(self, species, asm_one, asm_two, chromosome, start, end):
        self.species = species
        self.asm_one = asm_one
        self.asm_two = asm_two
        self.region = f'{chromosome}:{start}..{end}'
        self.server = 'https://rest.ensembl.org'
        self.ext = f'/map/{self.species}/{self.asm_one}/{self.region}/{self.asm_two}?'
        self.URL = self.server + self.ext
    
    def convert(self):
        print('[INFO] Loading Data from the URL')
        data = None
        try:
            response = requests.get(self.URL, headers = { "Content-Type" : "application/json"})
            if response.ok:
                data = response.json()
            else:
                response.raise_for_status()
        except Exception as e:
            print(f'[EXCEPTION] Could not load data due to this exception{e}')
        
        if data is not None and 'error' not in data.keys():
            print('[SUCCESS] Data loading successful.')
        else:
            if data is not None and 'error' in data.keys():
                print(f'[ERROR] Found the following error {data["error"]}')
        return data

class Printer:
    def __init__(self, file_name):
        self.file_name = file_name
    
    def dump_json_data(self, data):
        if '.' in self.file_name and self.file_name.rsplit('.')[1].lower() == 'json':
            try:
                with open(self.file_name, 'w', encoding='utf-8') as f:
                    json.dump(data, f, ensure_ascii=False, indent=4)
            except Exception as e:
                print(f'[EXCEPTION] could not dump data due to this exception {e}')
        else:
            print('[ERROR] file extension should be .json')

    def show_data_mappings(self, data):
        if 'mappings' in data.keys():
            if len(data['mappings']) == 0:
                print('[INFO] data is empty')
            for maps in data['mappings']:
                print(f'start = {maps["original"]["start"]}, end = {maps["original"]["end"]} ------ start = {maps["mapped"]["start"]}, end = {maps["mapped"]["end"]}')
        else:
            print('[ERROR] No mappings found')

   
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-s', '--species', default = 'human', help = 'Species name/alias, default value is human')
    parser.add_argument('-a1', '--asm_one', default = 'GRCh38', help = 'Version of the input assembly, default value is GRCh38')
    parser.add_argument('-a2', '--asm_two', default = 'GRCh37', help = 'Version of the output assembly, default value is GRCh37')
    parser.add_argument('-c', '--chromosome', required = True, help = 'Name of the chromosome [1-22] X Y.')
    parser.add_argument('-st', '--start', required = True, help = 'Start point for that chromosome.')
    parser.add_argument('-en', '--end', required = True, help = 'End point for that chromosome.')
    parser.add_argument('-f', '--file_name', default='data.json', help = 'Dumps Json data in the given given file, default file_name is data.json')
    args = parser.parse_args()
    converter = Converter(args.species, args.asm_one, args.asm_two, args.chromosome, args.start, args.end)
    data = converter.convert()
    if data is not None:
        printer = Printer(args.file_name)
        printer.dump_json_data(data)
        print(f'Showing Assembly Mapping from {args.asm_one} to {args.asm_two} for chromosome {args.chromosome} between {args.start} and {args.end}')
        printer.show_data_mappings(data)