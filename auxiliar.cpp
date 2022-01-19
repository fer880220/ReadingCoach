#include "auxiliar.h"

QString reverse(QString str){
    int len = str.length() ;
    QString result = str ;
    for(int i = len -1 ; i >=0 ; i--)
        result[ len - i - 1 ] = str[i] ;
    return result ;

}

Auxiliar::Auxiliar(QObject *parent) : QObject(parent), currentPos(0),
    reverseStr(false) , reverseSentence(false)
{
    settings = new QSettings("Fer","LecturaRapida") ;
    mcolor = QColor( settings->value( "texto/color" ).toString() );
    mbackground = QColor( settings->value( "texto/background" ).toString() );
    mfont.fromString(settings->value("texto/font").toString());
}

void Auxiliar::setStr(const QString &str){
    mlist = str.split(QRegExp("\\s+"));
    currentPos = 0 ;

}

QString Auxiliar::getNextPack()
{
    if(mlen < 0 || mlen > 500)
        return "";
    if(currentPos == mlist.length())
        return result ;
     result.clear();
     int stop = ((currentPos + mlen) > mlist.length() )? mlist.length() : (currentPos + mlen) ;

    QStringList lista ;

    for(int i = currentPos ; i < stop ; i++){
        if(!reverseStr)
            lista.push_back( mlist[i] ) ;
        else
            lista.push_back( reverse( mlist[i] ) ) ;
    }
    int len = lista.length() ;
    for(int i = 0 ; i < len ; i ++)
        if(!reverseSentence)
            result += lista[i]+" " ;
        else
            result += lista[len - i -1]+" " ;



    currentPos = stop ;
    return result ;

}

void Auxiliar::setFont(const QVariant &vf)
{
    mfont = vf.value<QFont>();
    settings->setValue("texto/font", vf.value<QFont>().toString());

    emit fontOrColorChanged();
}

void Auxiliar::setColor(const QVariant &vf)
{
    mcolor = vf.value<QColor>();
    settings->setValue("texto/color", vf.value<QColor>().name());

    emit fontOrColorChanged();
}

void Auxiliar::setBackground(const QVariant &vf)
{
    mbackground = vf.value<QColor>();
    settings->setValue("texto/background", vf.value<QColor>().name());

    emit fontOrColorChanged();
}
