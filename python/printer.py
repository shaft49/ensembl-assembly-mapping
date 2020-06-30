import json
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
