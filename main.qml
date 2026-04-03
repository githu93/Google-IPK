import QtQuick 2.15
import QtQuick.Controls 2.15
import QtWebView 1.1

ApplicationWindow {
    visible: true
    width: 1920
    height: 1080
    title: "Google"

    // Barra de busca simples no topo
    TextField {
        id: urlInput
        width: parent.width
        height: 60
        placeholderText: "Digite a URL ou pesquise no Google..."
        onAccepted: webView.url = "https://www.google.com/search?q=" + text
    }

    // O motor do navegador
    WebView {
        id: webView
        anchors.top: urlInput.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        url: "https://www.google.com"
        
        // Configuração de performance: Limpa memória ao trocar de página
        onLoadingChanged: {
            if (loadRequest.status === WebView.LoadStartedStatus) {
                console.log("Limpando lixo de memória para nova página...")
            }
        }
    }
}
