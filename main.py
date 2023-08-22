# This Python file uses the following encoding: utf-8
import sys
import os
from pyo import *
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

from PyoThread import PyoThread


if __name__ == "__main__":
    os.environ['QML_XHR_ALLOW_FILE_READ'] = '1'
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    qml_file = Path(__file__).resolve().parent / "main.qml"
    engine.load(qml_file)

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
