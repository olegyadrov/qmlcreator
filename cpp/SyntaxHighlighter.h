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

#ifndef SYNTAXHIGHLIGHTER_H
#define SYNTAXHIGHLIGHTER_H

#include <QObject>
#include <QQuickTextDocument>
#include "QMLHighlighter.h"

class SyntaxHighlighter : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QColor normalColor    MEMBER m_normalColor    READ normalColor    WRITE setNormalColor    NOTIFY normalColorChanged)
    Q_PROPERTY(QColor commentColor   MEMBER m_commentColor   READ commentColor   WRITE setCommentColor   NOTIFY commentColorChanged)
    Q_PROPERTY(QColor numberColor    MEMBER m_numberColor    READ numberColor    WRITE setNumberColor    NOTIFY numberColorChanged)
    Q_PROPERTY(QColor stringColor    MEMBER m_stringColor    READ stringColor    WRITE setStringColor    NOTIFY stringColorChanged)
    Q_PROPERTY(QColor operatorColor  MEMBER m_operatorColor  READ operatorColor  WRITE setOperatorColor  NOTIFY operatorColorChanged)
    Q_PROPERTY(QColor keywordColor   MEMBER m_keywordColor   READ keywordColor   WRITE setKeywordColor   NOTIFY keywordColorChanged)
    Q_PROPERTY(QColor builtInColor   MEMBER m_builtInColor   READ builtInColor   WRITE setBuiltInColor   NOTIFY builtInColorChanged)
    Q_PROPERTY(QColor markerColor    MEMBER m_markerColor    READ markerColor    WRITE setMarkerColor    NOTIFY markerColorChanged)
    Q_PROPERTY(QColor itemColor      MEMBER m_itemColor      READ itemColor      WRITE setItemColor      NOTIFY itemColorChanged)
    Q_PROPERTY(QColor propertyColor  MEMBER m_propertyColor  READ propertyColor  WRITE setPropertyColor  NOTIFY propertyColorChanged)

public:
    explicit SyntaxHighlighter(QObject *parent = 0);
    Q_INVOKABLE void setHighlighter(QObject *textArea);
    Q_INVOKABLE void rehighlight();
    Q_INVOKABLE void addQmlComponent(QString componentName);
    Q_INVOKABLE void addJsComponent(QString componentName);

    QColor normalColor();
    QColor commentColor();
    QColor numberColor();
    QColor stringColor();
    QColor operatorColor();
    QColor keywordColor();
    QColor builtInColor();
    QColor markerColor();
    QColor itemColor();
    QColor propertyColor();

    void setNormalColor(QColor color);
    void setCommentColor(QColor color);
    void setNumberColor(QColor color);
    void setStringColor(QColor color);
    void setOperatorColor(QColor color);
    void setKeywordColor(QColor color);
    void setBuiltInColor(QColor color);
    void setMarkerColor(QColor color);
    void setItemColor(QColor color);
    void setPropertyColor(QColor color);

private:
    QMLHighlighter *m_highlighter;

    QColor m_normalColor;
    QColor m_commentColor;
    QColor m_numberColor;
    QColor m_stringColor;
    QColor m_operatorColor;
    QColor m_keywordColor;
    QColor m_builtInColor;
    QColor m_markerColor;
    QColor m_itemColor;
    QColor m_propertyColor;

signals:
    void normalColorChanged();
    void commentColorChanged();
    void numberColorChanged();
    void stringColorChanged();
    void operatorColorChanged();
    void keywordColorChanged();
    void builtInColorChanged();
    void markerColorChanged();
    void itemColorChanged();
    void propertyColorChanged();
};


#endif // SYNTAXHIGHLIGHTER_H
