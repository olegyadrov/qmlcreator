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

#include "SyntaxHighlighter.h"

SyntaxHighlighter::SyntaxHighlighter(QObject *parent) :
    QObject(parent),
    m_highlighter(NULL)
{
    Q_UNUSED(parent)
}

void SyntaxHighlighter::setHighlighter(QObject *textArea)
{
    QQuickTextDocument *quickTextDocument = qvariant_cast<QQuickTextDocument*>(textArea->property("textDocument"));
    QTextDocument *document = quickTextDocument->textDocument();
    m_highlighter = new QMLHighlighter(document);

    m_highlighter->setColor(QMLHighlighter::Normal, m_normalColor);
    m_highlighter->setColor(QMLHighlighter::Comment, m_commentColor);
    m_highlighter->setColor(QMLHighlighter::Number, m_numberColor);
    m_highlighter->setColor(QMLHighlighter::String, m_stringColor);
    m_highlighter->setColor(QMLHighlighter::Operator, m_operatorColor);
    m_highlighter->setColor(QMLHighlighter::Keyword, m_keywordColor);
    m_highlighter->setColor(QMLHighlighter::BuiltIn, m_builtInColor);
    m_highlighter->setColor(QMLHighlighter::Marker, m_markerColor);
    m_highlighter->setColor(QMLHighlighter::Item, m_itemColor);
    m_highlighter->setColor(QMLHighlighter::Property, m_propertyColor);

    m_highlighter->rehighlight();
}

void SyntaxHighlighter::rehighlight() {
    if (m_highlighter)
        m_highlighter->rehighlight();
}

void SyntaxHighlighter::addQmlComponent(QString componentName)
{
    if (m_highlighter)
        m_highlighter->addQmlComponent(componentName);
}

void SyntaxHighlighter::addJsComponent(QString componentName)
{
    if (m_highlighter)
        m_highlighter->addJsComponent(componentName);
}

QColor SyntaxHighlighter::normalColor()
{
    return m_normalColor;
}

QColor SyntaxHighlighter::commentColor()
{
    return m_commentColor;
}

QColor SyntaxHighlighter::numberColor()
{
    return m_numberColor;
}

QColor SyntaxHighlighter::stringColor()
{
    return m_stringColor;
}

QColor SyntaxHighlighter::operatorColor()
{
    return m_operatorColor;
}

QColor SyntaxHighlighter::keywordColor()
{
    return m_keywordColor;
}

QColor SyntaxHighlighter::builtInColor()
{
    return m_builtInColor;
}

QColor SyntaxHighlighter::markerColor()
{
    return m_markerColor;
}

QColor SyntaxHighlighter::itemColor()
{
    return m_itemColor;
}

QColor SyntaxHighlighter::propertyColor()
{
    return m_propertyColor;
}

void SyntaxHighlighter::setNormalColor(QColor color)
{
    if (m_normalColor != color)
    {
        m_normalColor = color;

        if (m_highlighter)
            m_highlighter->setColor(QMLHighlighter::Normal, m_normalColor);

        emit normalColorChanged();
    }
}

void SyntaxHighlighter::setCommentColor(QColor color)
{
    if (m_commentColor != color)
    {
        m_commentColor = color;

        if (m_highlighter)
            m_highlighter->setColor(QMLHighlighter::Comment, m_commentColor);

        emit commentColorChanged();
    }
}

void SyntaxHighlighter::setNumberColor(QColor color)
{
    if (m_numberColor != color)
    {
        m_numberColor = color;

        if (m_highlighter)
            m_highlighter->setColor(QMLHighlighter::Number, m_numberColor);

        emit numberColorChanged();
    }
}

void SyntaxHighlighter::setStringColor(QColor color)
{
    if (m_stringColor != color)
    {
        m_stringColor = color;

        if (m_highlighter)
            m_highlighter->setColor(QMLHighlighter::String, m_stringColor);

        emit stringColorChanged();
    }
}

void SyntaxHighlighter::setOperatorColor(QColor color)
{
    if (m_operatorColor != color)
    {
        m_operatorColor = color;

        if (m_highlighter)
            m_highlighter->setColor(QMLHighlighter::Operator, m_operatorColor);

        emit operatorColorChanged();
    }
}

void SyntaxHighlighter::setKeywordColor(QColor color)
{
    if (m_keywordColor != color)
    {
        m_keywordColor = color;

        if (m_highlighter)
            m_highlighter->setColor(QMLHighlighter::Keyword, m_keywordColor);

        emit keywordColorChanged();
    }
}

void SyntaxHighlighter::setBuiltInColor(QColor color)
{
    if (m_builtInColor != color)
    {
        m_builtInColor = color;

        if (m_highlighter)
            m_highlighter->setColor(QMLHighlighter::BuiltIn, m_builtInColor);

        emit builtInColorChanged();
    }
}

void SyntaxHighlighter::setMarkerColor(QColor color)
{
    if (m_markerColor != color)
    {
        m_markerColor = color;

        if (m_highlighter)
            m_highlighter->setColor(QMLHighlighter::Marker, m_markerColor);

        emit markerColorChanged();
    }
}

void SyntaxHighlighter::setItemColor(QColor color)
{
    if (m_itemColor != color)
    {
        m_itemColor = color;

        if (m_highlighter)
            m_highlighter->setColor(QMLHighlighter::Item, m_itemColor);

        emit itemColorChanged();
    }
}

void SyntaxHighlighter::setPropertyColor(QColor color)
{
    if (m_propertyColor != color)
    {
        m_propertyColor = color;

        if (m_highlighter)
            m_highlighter->setColor(QMLHighlighter::Property, m_propertyColor);

        emit propertyColorChanged();
    }
}
