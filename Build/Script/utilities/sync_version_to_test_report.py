import codecs
import json
import sys


def main() -> int:
    report_path = sys.argv[1]
    report_version = sys.argv[2]
    index_json = report_path + "/index.json"

    with codecs.open(index_json, "r", "utf-8-sig") as json_file:
        data = json.load(json_file)
        if "clientDescriptor" in data:
            data["clientDescriptor"] = data["clientDescriptor"] + " - " + report_version
            print("[Info] clientDescriptor changed to: " + data["clientDescriptor"])
        elif "platform" in data:
            data["platform"] = data["platform"] + report_version
            print("[Info] platform changed to: " + data["platform"])

    with codecs.open(index_json, "w", "utf-8-sig") as json_file:
        json.dump(data, json_file)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
