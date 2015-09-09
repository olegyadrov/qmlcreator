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

#ifndef QMLHIGHLIGHTER_H
#define QMLHIGHLIGHTER_H

#include <QSyntaxHighlighter>
#include <QTextStream>

class QMLHighlighter : public QSyntaxHighlighter
{
    Q_OBJECT

public:
    enum ColorComponent {
        Normal,
        Comment,
        Number,
        String,
        Operator,
        Keyword,
        BuiltIn,
        Marker,
        Item,
        Property
    };

    QMLHighlighter(QTextDocument *parent = 0);
    void setColor(ColorComponent component, const QColor &color);
    void mark(const QString &str, Qt::CaseSensitivity caseSensitivity);
    void addQmlComponent(QString componentName);
    void addJsComponent(QString componentName);

protected:
    void highlightBlock(const QString &text);

private:
    void loadDictionary(QString filepath, QSet<QString> &dictionary);
    static bool m_cacheLoaded;
    static QSet<QString> m_keywordsCache;
    static QSet<QString> m_jsIdsCache;
    static QSet<QString> m_qmlIdsCache;
    static QSet<QString> m_propertiesCache;

    QSet<QString> m_jsIds;
    QSet<QString> m_qmlIds;

    QHash<ColorComponent, QColor> m_colors;
    QString m_markString;
    Qt::CaseSensitivity m_markCaseSensitivity;
};

#endif // QMLHIGHLIGHTER_H
