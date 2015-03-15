# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file '/home/d9k/pr/_eric/minibrowser/ui/mainwindow.ui'
#
# Created: Thu Jun 26 05:13:46 2014
#      by: PyQt4 UI code generator 4.10.4
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    def _fromUtf8(s):
        return s

try:
    _encoding = QtGui.QApplication.UnicodeUTF8
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig, _encoding)
except AttributeError:
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig)

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName(_fromUtf8("MainWindow"))
        MainWindow.resize(800, 600)
        self.centralWidget = QtGui.QWidget(MainWindow)
        self.centralWidget.setObjectName(_fromUtf8("centralWidget"))
        self.gridLayout = QtGui.QGridLayout(self.centralWidget)
        self.gridLayout.setObjectName(_fromUtf8("gridLayout"))
        self.horizontalLayout = QtGui.QHBoxLayout()
        self.horizontalLayout.setObjectName(_fromUtf8("horizontalLayout"))
        self.txtUrl = QtGui.QLineEdit(self.centralWidget)
        self.txtUrl.setObjectName(_fromUtf8("txtUrl"))
        self.horizontalLayout.addWidget(self.txtUrl)
        self.bNavigate = QtGui.QPushButton(self.centralWidget)
        self.bNavigate.setObjectName(_fromUtf8("bNavigate"))
        self.horizontalLayout.addWidget(self.bNavigate)
        self.gridLayout.addLayout(self.horizontalLayout, 0, 0, 1, 1)
        self.webview = KWebView(self.centralWidget)
        self.webview.setObjectName(_fromUtf8("webview"))
        self.gridLayout.addWidget(self.webview, 1, 0, 1, 1)
        MainWindow.setCentralWidget(self.centralWidget)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow", None))
        self.bNavigate.setText(_translate("MainWindow", "Navigate", None))

from kwebview import KWebView

if __name__ == "__main__":
    import sys
    app = QtGui.QApplication(sys.argv)
    MainWindow = QtGui.QMainWindow()
    ui = Ui_MainWindow()
    ui.setupUi(MainWindow)
    MainWindow.show()
    sys.exit(app.exec_())

