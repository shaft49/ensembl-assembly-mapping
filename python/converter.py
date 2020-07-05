
import requests
class Converter:
    def __init__(self, species, asm_one, asm_two, chromosome, start, end, strand):
        self.species = species
        self.asm_one = asm_one
        self.asm_two = asm_two
        self.region = f'{chromosome}:{start}..{end}'
        if strand:
            self.region += f':{strand}'
        self.server = 'http://rest.ensembl.org'
        self.ext = f'/map/{self.species}/{self.asm_one}/{self.region}/{self.asm_two}?'
        self.URL = self.server + self.ext + "content-type=application/json"
    
    def convert(self):
        print('[INFO] Loading Data from the URL')
        data = None
        try:
            response = requests.get(self.URL)
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
