/****************************************************************************
**
** Copyright (C) 2013-2015 Oleg Yadrov
**
** Licensed under the Apache License, Version 2.0 (the "License");
** you may not use this file except in compliance with the License.
** You may obtain a copy of the License at
**
** http://www.apache.org/licenses/LICENSE-2.0
**
** Unless required by applicable law or agreed to in writing, software
** distributed under the License is distributed on an "AS IS" BASIS,
** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
** See the License for the specific language governing permissions and
** limitations under the License.
**
****************************************************************************/

#include "QMLHighlighter.h"

class QMLBlockData: public QTextBlockUserData
{
public:
    QList<int> bracketPositions;
};

bool QMLHighlighter::m_cacheLoaded = false;
QSet<QString> QMLHighlighter::m_keywordsCache = QSet<QString>();
QSet<QString> QMLHighlighter::m_jsIdsCache = QSet<QString>();
QSet<QString> QMLHighlighter::m_qmlIdsCache = QSet<QString>();
QSet<QString> QMLHighlighter::m_propertiesCache = QSet<QString>();

QMLHighlighter::QMLHighlighter(QTextDocument *parent) : QSyntaxHighlighter(parent)
    , m_markCaseSensitivity(Qt::CaseInsensitive)
{
    if (!m_cacheLoaded) {
        loadDictionary(":/resources/dictionaries/keywords.txt", m_keywordsCache);
        loadDictionary(":/resources/dictionaries/javascript.txt", m_jsIdsCache);
        loadDictionary(":/resources/dictionaries/qml.txt", m_qmlIdsCache);
        loadDictionary(":/resources/dictionaries/properties.txt", m_propertiesCache);
        m_cacheLoaded = true;
    }
}

void QMLHighlighter::setColor(ColorComponent component, const QColor &color)
{
    m_colors[component] = color;
}

void QMLHighlighter::highlightBlock(const QString &text)
{
    enum {
        Start = 0,
        Number = 1,
        Identifier = 2,
        String = 3,
        Comment = 4
    };

    QList<int> bracketPositions;

    int blockState = previousBlockState();
    int bracketLevel = blockState >> 4;
    int state = blockState & 15;
    if (blockState < 0) {
        bracketLevel = 0;
        state = Start;
    }

    int start = 0;
    int i = 0;
    while (i <= text.length()) {
        QChar ch = (i < text.length()) ? text.at(i) : QChar();
        QChar next = (i < text.length() - 1) ? text.at(i + 1) : QChar();

        switch (state) {

        case Start:
            start = i;
            if (ch.isSpace()) {
                ++i;
            } else if (ch.isDigit()) {
                ++i;
                state = Number;
            } else if (ch.isLetter() || ch == '_') {
                ++i;
                state = Identifier;
            } else if (ch == '\'' || ch == '\"') {
                ++i;
                state = String;
            } else if (ch == '/' && next == '*') {
                ++i;
                ++i;
                state = Comment;
            } else if (ch == '/' && next == '/') {
                i = text.length();
                setFormat(start, text.length(), m_colors[ColorComponent::Comment]);
            } else {
                if (!QString("(){}[]").contains(ch))
                    setFormat(start, 1, m_colors[Operator]);
                if (ch =='{' || ch == '}') {
                    bracketPositions += i;
                    if (ch == '{')
                        bracketLevel++;
                    else
                        bracketLevel--;
                }
                ++i;
                state = Start;
            }
            break;

        case Number:
            if (ch.isSpace() || !ch.isDigit()) {
                setFormat(start, i - start, m_colors[ColorComponent::Number]);
                state = Start;
            } else {
                ++i;
            }
            break;

        case Identifier:
            if (ch.isSpace() || !(ch.isDigit() || ch.isLetter() || ch == '_')) {
                QString token = text.mid(start, i - start).trimmed();
                if (m_keywordsCache.contains(token))
                    setFormat(start, i - start, m_colors[Keyword]);
                else if (m_qmlIdsCache.contains(token) || m_qmlIds.contains(token))
                    setFormat(start, i - start, m_colors[Item]);
                else if (m_propertiesCache.contains(token))
                    setFormat(start, i - start, m_colors[Property]);
                else if (m_jsIdsCache.contains(token) || m_jsIds.contains(token))
                    setFormat(start, i - start, m_colors[BuiltIn]);
                state = Start;
            } else {
                ++i;
            }
            break;

        case String:
            if (ch == text.at(start)) {
                QChar prev = (i > 0) ? text.at(i - 1) : QChar();
                if (prev != '\\') {
                    ++i;
                    setFormat(start, i - start, m_colors[ColorComponent::String]);
                    state = Start;
                } else {
                    ++i;
                }
            } else {
                ++i;
            }
            break;

        case Comment:
            if (ch == '*' && next == '/') {
                ++i;
                ++i;
                setFormat(start, i - start, m_colors[ColorComponent::Comment]);
                state = Start;
            } else {
                ++i;
            }
            break;

        default:
            state = Start;
            break;
        }
    }

    if (state == Comment)
        setFormat(start, text.length(), m_colors[ColorComponent::Comment]);
    else
        state = Start;

    if (!m_markString.isEmpty()) {
        int pos = 0;
        int len = m_markString.length();
        QTextCharFormat markerFormat;
        markerFormat.setBackground(m_colors[ColorComponent::Marker]);
        markerFormat.setForeground(m_colors[ColorComponent::Normal]);
        for (;;) {
            pos = text.indexOf(m_markString, pos, m_markCaseSensitivity);
            if (pos < 0)
                break;
            setFormat(pos, len, markerFormat);
            ++pos;
        }
    }

    if (!bracketPositions.isEmpty()) {
        QMLBlockData *blockData = reinterpret_cast<QMLBlockData*>(currentBlock().userData());
        if (!blockData) {
            blockData = new QMLBlockData;
            currentBlock().setUserData(blockData);
        }
        blockData->bracketPositions = bracketPositions;
    }

    blockState = (state & 15) | (bracketLevel << 4);
    setCurrentBlockState(blockState);
}

void QMLHighlighter::mark(const QString &str, Qt::CaseSensitivity caseSensitivity)
{
    m_markString = str;
    m_markCaseSensitivity = caseSensitivity;
    rehighlight();
}

void QMLHighlighter::loadDictionary(QString filepath, QSet<QString> &dictionary) {
    QFile file(filepath);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QTextStream textStream(&file);
    while (!textStream.atEnd()) {
        dictionary<<textStream.readLine().trimmed();
    }
}

void QMLHighlighter::addQmlComponent(QString componentName)
{
    m_qmlIds<<componentName;
}

void QMLHighlighter::addJsComponent(QString componentName)
{
    m_jsIds<<componentName;
}
