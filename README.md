# tasty-tracker
# 1. O projekcie

Baza danych tworzona w ramach projektu składa się z dwóch części. Pierwszym jej zastosowaniem jest przechowywanie informacji o przepisach - od tych podstawowych, jak autor czy stopień trudności i czas wykonania, po bardziej szczegółowe, jak statystyki dotyczące liczby przeglądań czy polubień oraz tagi. Druga część bazy danych zawiera informacje o użytkownikach korzystających z katalogu przepisów. Są to między innymi dane dotyczące konta użytkownika, jak hasz hasła czy data założenia konta, oraz aktywności użytkownika, na przykład polubione przez niego przepisy. Informacje o użytkowniku są przechowywane do momentu usunięcia przez niego konta, jednak przepisy dodane przez niego są dostępne również później jako wpisy archiwalne.

# 2. Funkcjonalności

Możliwości przewidziane dla użytkowników istniejących w bazie

* Dodawania przepisów oraz edytowanie własnych dodanych wcześniej
* Oznaczanie przepisów jako polubione lub usuwanie z listy polubionych przez siebie
* Sprawdzenie liczby polubień przepisów użytkownika
* Sortowanie przepisów po czasie przygotowania, liczbie polubień
* Wyszukiwanie przepisów po trudności, tagach, etc.
* Wyszukiwanie przepisów, podając listę składników do wykorzystania
* Przygotowywanie listy zakupów na podstawie podanych składników oraz tych potrzebnych do przepisu
