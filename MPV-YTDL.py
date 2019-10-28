#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
author: Josh Fowler
website: glitchbusters.info
last edited: December 2017

"""

import sys
import os

from PyQt4 import QtGui


class Example(QtGui.QWidget):

    def __init__(self):
        super(Example, self).__init__()

        self.initUI()

    def initUI(self):

        self.btn = QtGui.QPushButton('Click me', self)
        self.btn.move(5, 5)
        self.btn.clicked.connect(self.showDialog)

        self.setGeometry(300, 300, 85, 35)
        self.setWindowTitle('MPV-YTDL')
        self.show()

    def showDialog(self):

        text, ok = QtGui.QInputDialog.getText(self, 'Input Dialog',
            'Enter your the URL below')

        if ok:
            os.system ('mpv ' + text)

def main():

    app = QtGui.QApplication(sys.argv)
    ex = Example()
    sys.exit(app.exec_())


if __name__ == '__main__':
    main()