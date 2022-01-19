#ifndef AUXILIAR_H
#define AUXILIAR_H

#include <QObject>
#include <QSettings>
#include <QFont>
#include <QColor>

class Auxiliar : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariant font READ getFont() WRITE setFont NOTIFY fontOrColorChanged)
    Q_PROPERTY(QVariant color READ getColor() WRITE setColor NOTIFY fontOrColorChanged)
    Q_PROPERTY(QVariant background READ getBackground() WRITE setBackground NOTIFY fontOrColorChanged)

public:
    explicit Auxiliar(QObject *parent = 0);

signals:
    void fontOrColorChanged() ;
public slots:
    float toFloat(QString str){ return str.toFloat() ;    }
    void setStr(const QString &str);
    void setLenPack(int len){ mlen = len ; }
    QString getNextPack() ;

    void setReverseStr(bool b){ reverseStr = b ;}
    void setReverseSentence(bool b) { reverseSentence = b ; }
    bool getReverseStr(){ return reverseStr ; }
    bool getReverseSentence(){ return reverseSentence ; }

    void setFont(const QVariant &vf);
    QFont getFont(){return mfont; }
    void setColor(const QVariant &vf);
    QColor getColor(){ return mcolor ; }
    void setBackground(const QVariant &vf);
    QColor getBackground(){ return mbackground ; }

private:
    QString result ;
    QStringList mlist;
    int mlen, currentPos ;
    bool reverseStr, reverseSentence ;

    QSettings *settings;

    QFont mfont;
    QColor mcolor,
    mbackground;
};

#endif // AUXILIAR_H
