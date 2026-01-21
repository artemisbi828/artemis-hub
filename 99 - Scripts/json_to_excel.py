import sublime
import sublime_plugin
import json

class JsonToExcelTableCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        for region in self.view.sel():
            if region.empty():
                region = sublime.Region(0, self.view.size())
            
            content = self.view.substr(region)
            
            try:
                # Parse the JSON
                data = json.loads(content)
                
                output_rows = []
                headers = []
                
                # Logic to handle the specific structure provided
                # It looks for keys (like "ticket") that contain lists of objects
                for category, items in data.items():
                    if isinstance(items, list):
                        for item in items:
                            # Build headers dynamically from the first item found
                            if not headers:
                                headers = ["Type"] + [k[0].upper() + k[1:] for k in item.keys()]
                                output_rows.append("\t".join(headers))
                            
                            # Build the row: Category (Ticket) + values
                            row = [category.capitalize()] + [str(v) for v in item.values()]
                            output_rows.append("\t".join(row))
                
                # Replace the text with the tab-delimited table
                self.view.replace(edit, region, "\n".join(output_rows))
                
            except Exception as e:
                sublime.error_message("JSON Parsing Error: " + str(e))