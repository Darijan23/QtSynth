# This Python file uses the following encoding: utf-8
import sys
from pyo import *
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

from PyoThread import PyoThread


if __name__ == "__main__":
    pyoThread = PyoThread()
    pyoThread.start()

    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    qml_file = Path(__file__).resolve().parent / "main.qml"
    engine.load(qml_file)
    engine.rootContext().setContextProperty("pyo", pyoThread)

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
