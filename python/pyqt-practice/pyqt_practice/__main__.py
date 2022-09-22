import sys

from PyQt6.uic import loadUi
from PyQt6.QtWidgets import QApplication
from functools import partial

ROOT_PATH = '/Users/kensukenakazawa/Develop/Playgrounds/python/pyqt-practice/pyqt_practice'


def change_view(page1, page2):  # dlg1 -> dlg2に遷移させる
    position = page1.pos()
    size = page1.size()
    page2.move(position.x(), position.y())
    page2.resize(size)
    page2.show()
    page1.hide()



def main():
    application = QApplication([])
    main_windows = loadUi(f'{ROOT_PATH}/views/main.ui')
    evaluate_window = loadUi(f'{ROOT_PATH}/views/evaluate.ui')
    main_windows.show()
    main_windows.pushButton_2.clicked.connect(partial(change_view, page1=main_windows, page2=evaluate_window))
    evaluate_window.home_button.clicked.connect(partial(change_view, page1=evaluate_window, page2=main_windows))

    application.exec()


if __name__ == '__main__':
    main()
