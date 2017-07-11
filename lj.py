#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2017 vimsucks <dev@vimsucks.com>
#
# Distributed under terms of the MIT license.

"""

"""

import click
import random
import time


romajiHiragana = {
        "a ":   "あ",
        "i ":   "い",
        "u ":   "う",
        "e ":   "え",
        "o ":   "お",
        "ka":  "か",
        "ki":  "き",
        "ku":  "く",
        "ke":  "け",
        "ko":  "こ",
        "sa":  "さ",
        "shi": "し",
        "su":  "す",
        "se":  "せ",
        "so":  "そ",
        "ta":  "た",
        "chi": "ち ",
        "tsu": "つ ",
        "te":  "て",
        "to":  "と",
        "na":  "な",
        "ni":  "に",
        "nu":  "ぬ",
        "ne":  "ね",
        "no":  "の",
        "ha":  "は",
        "hi":  "ひ",
        "fu":  "ふ",
        "he":  "へ",
        "ho":  "ほ",
        "ma":  "ま",
        "mi":  "み",
        "mu":  "む",
        "me":  "め",
        "mo":  "も",
        "ya":  "や",
        "yu":  "ゆ",
        "yo":  "よ",
        "ra":  "ら",
        "ri":  "り",
        "ru":  "る",
        "re":  "れ",
        "ro":  "ろ",
        "wa":  "わ",
        "wo":  "を",
        "あ":   "a ",
        "い":   "i ",
        "う":   "u ",
        "え":   "e ",
        "お":   "o ",
        "か":  "ka",
        "き":  "ki",
        "く":  "ku",
        "け":  "ke",
        "こ":  "ko",
        "さ":  "sa",
        "し": "shi",
        "す":  "su",
        "せ":  "se",
        "そ":  "so",
        "た":  "ta",
        "ち ": "chi",
        "つ ": "tsu",
        "て":  "te",
        "と":  "to",
        "な":  "na",
        "に":  "ni",
        "ぬ":  "nu",
        "ね":  "ne",
        "の":  "no",
        "は":  "ha",
        "ひ":  "hi",
        "ふ":  "fu",
        "へ":  "he",
        "ほ":  "ho",
        "ま":  "ma",
        "み":  "mi",
        "む":  "mu",
        "め":  "me",
        "も":  "mo",
        "や":  "ya",
        "ゆ":  "yu",
        "よ":  "yo",
        "ら":  "ra",
        "り":  "ri",
        "る":  "ru",
        "れ":  "re",
        "ろ":  "ro",
        "わ":  "wa",
        "を":  "wo"}

romajiKatagana = {
        "a ":   "ア",
        "i ":   "イ",
        "u ":   "ウ",
        "e ":   "エ",
        "o ":   "オ",
        "ka":  "カ",
        "ki":  "キ",
        "ku":  "ク",
        "ke":  "ケ",
        "ko":  "コ",
        "sa":  "サ",
        "shi": "シ",
        "su":  "ス",
        "se":  "セ",
        "so":  "ソ",
        "ta":  "タ",
        "chi": "チ ",
        "tsu": "ツ ",
        "te":  "テ",
        "to":  "ト",
        "na":  "ナ",
        "ni":  "ニ",
        "nu":  "ヌ",
        "ne":  "ネ",
        "no":  "ノ",
        "ha":  "ハ",
        "hi":  "ヒ",
        "fu":  "フ",
        "he":  "ヘ",
        "ho":  "ホ",
        "ma":  "マ",
        "mi":  "ミ",
        "mu":  "ム",
        "me":  "メ",
        "mo":  "モ",
        "ya":  "ヤ",
        "yu":  "ユ",
        "yo":  "ヨ",
        "ra":  "ラ",
        "ri":  "リ",
        "ru":  "ル",
        "re":  "レ",
        "ro":  "ロ",
        "wa":  "ワ",
        "wo":  "ヲ",
        "ア":   "a ",
        "イ":   "i ",
        "ウ":   "u ",
        "エ":   "e ",
        "オ":   "o ",
        "カ":  "ka",
        "キ":  "ki",
        "ク":  "ku",
        "ケ":  "ke",
        "コ":  "ko",
        "サ":  "sa",
        "シ": "shi",
        "ス":  "su",
        "セ":  "se",
        "ソ":  "so",
        "タ":  "ta",
        "チ ": "chi",
        "ツ ": "tsu",
        "テ":  "te",
        "ト":  "to",
        "ナ":  "na",
        "ニ":  "ni",
        "ヌ":  "nu",
        "ネ":  "ne",
        "ノ":  "no",
        "ハ":  "ha",
        "ヒ":  "hi",
        "フ":  "fu",
        "ヘ":  "he",
        "ホ":  "ho",
        "マ":  "ma",
        "ミ":  "mi",
        "ム":  "mu",
        "メ":  "me",
        "モ":  "mo",
        "ヤ":  "ya",
        "ユ":  "yu",
        "ヨ":  "yo",
        "ラ":  "ra",
        "リ":  "ri",
        "ル":  "ru",
        "レ":  "re",
        "ロ":  "ro",
        "ワ":  "wa",
        "ヲ":  "wo"}

hir = [h for h in romajiHiragana.keys()]
kat = [k for k in romajiKatagana.keys()]


@click.group("Learning Gojuon")
def main():
    pass


@main.command("h")
def hiragana():
    while True:
        random.seed(time.ctime())
        q, a = [], []
        mode = random.randint(0, 1)
        for i in range(10):
            k = random.choice(hir)
            v = romajiHiragana[k]
            q.append(k)
            a.append(v)
        print("Q: " + str(q), end="")
        input()
        print("A: " + str(a), end="")
        input()


@main.command("k")
def katagana():
    while True:
        random.seed(time.ctime())
        q, a = [], []
        q, a = [], []
        mode = random.randint(0, 1)
        for i in range(10):
            k = random.choice(kat)
            v = romajiKatagana[k]
            q.append(k)
            a.append(v)
        print("Q: " + str(q), end="")
        input()
        print("A: " + str(a), end="")
        input()


if __name__ == "__main__":
    main()
