import argparse
import requests

class Converter:
    def __init__(self, chromosome, start, end):
        self.CONVERT_FROM = 'GRCh38'
        self.CONVERT_TO = 'GRCh37'
        self.CHROMOSOME = chromosome
        self.START = start
        self.END = end
        self.URL = f'https://rest.ensembl.org/map/human/{self.CONVERT_FROM}/{self.CHROMOSOME}:{self.START}..{self.END}/{self.CONVERT_TO}?content-type=application/json'

    def show_data_mappings(self, data):
        if 'mappings' in data.keys():
            for maps in data['mappings']:
                print(f'{self.CONVERT_FROM}: start = {maps["original"]["start"]}, end = {maps["original"]["end"]} ---- {self.CONVERT_TO}: start = {maps["mapped"]["start"]}, end = {maps["mapped"]["end"]}')
        else:
            print('[INFO] No mappings found')
    
    def convert(self):
        print('[INFO] Loading Data from the URL')
        json_data = None
        try:
            data = requests.get(self.URL)
            json_data = data.json()
        except Exception as e:
            print(f'[INFO] Could not load data due to this exception{e}')
        
        if json_data is not None and 'error' not in json_data.keys():
            print('[INFO] Data loading successful.')
            self.show_data_mappings(json_data)
        else:
            print('[INFO] Found the following error')
            print(json_data)
        return json_data
    
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-c', '--chromosome', required = True, help = 'Name of the chromosome [1-22] X Y.')
    parser.add_argument('-s', '--start', required = True, help = 'Start point for that chromosome.')
    parser.add_argument('-e', '--end', required = True, help = 'End point for that chromosome.')
    args = parser.parse_args()
    converter = Converter(args.chromosome, args.start, args.end)
    json_data = converter.convert()