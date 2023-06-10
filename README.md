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

# 3. Aplikacja
## Instalacja
Instalacja Dockera
```sh
curl -fsSL https://get.docker.com | sh
```
Po instalacji należy [skonfigurować](https://docs.docker.com/engine/install/linux-postinstall/) dockera (w szczególności dodać usera do grupy dockerowej)
## Uruchomienie
Najpierw należy uruchomić docker.service
```sh
systemctl start docker
```
A następnie w folderze tasty-tracker
```sh
docker-compose up --build 
```
Aplikacja domyślmnie uruchamiana jest na `localhost:8000`
## Użytkowanie
Aplikacja pozwala na wyświetlanie/dodawanie/edytowanie przepisów.

W celu edytownia swojego przepisu lub stworzenia nowego, należy najpierw zalogować się na odpowiednie konto.

Przejście do edycji przepisu następuje przez przycisk `Edit` w widoku danego przepisu.

Do dodawania nowego przepisu służy przycisk `New recipe` w górnym pasku.

Będąc zalogowanym, można również dodawać i usuwać polubienia przepisów.

Aby wrócić do listy przepisów należy kilknąć w prycisk znajdujący się na górnym pasku (logo tasty-tracker).
