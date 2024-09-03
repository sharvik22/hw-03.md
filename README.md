# Домашнее задание к занятию «Управляющие конструкции в коде Terraform» Шарапат Виктор

### Цели задания

1. Отработать основные принципы и методы работы с управляющими конструкциями Terraform.
2. Освоить работу с шаблонизатором Terraform (Interpolation Syntax).

------

### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Доступен исходный код для выполнения задания в директории [**03/src**](https://github.com/netology-code/ter-homeworks/tree/main/03/src).
4. Любые ВМ, использованные при выполнении задания, должны быть прерываемыми, для экономии средств.

------

### Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!
Убедитесь что ваша версия **Terraform** ~>1.8.4
Теперь пишем красивый код, хардкод значения не допустимы!
------

### Задание 1

1. Изучите проект.
2. Заполните файл personal.auto.tfvars.
3. Инициализируйте проект, выполните код. Он выполнится, даже если доступа к preview нет.

Примечание. Если у вас не активирован preview-доступ к функционалу «Группы безопасности» в Yandex Cloud, запросите доступ у поддержки облачного провайдера. Обычно его выдают в течение 24-х часов.

Приложите скриншот входящих правил «Группы безопасности» в ЛК Yandex Cloud или скриншот отказа в предоставлении доступа к preview-версии.

### Решение 1

* Заполните файл personal.auto.tfvars. Чтобы "не светить токен" я добавил service_account_key_file = file("~/.authorized_key.json"). 

![image](https://github.com/user-attachments/assets/5c6f0251-88d0-4d10-93bf-04550c657506)

* Инициализируйте проект, выполните код. Он выполнится, даже если доступа к preview нет.

![image](https://github.com/user-attachments/assets/991df1fc-d965-4966-af86-7a7a442ac7c7)

![image](https://github.com/user-attachments/assets/f87ce876-9115-41d7-b2d0-3cf5e230ea14)

![image](https://github.com/user-attachments/assets/03fe517e-f6ee-4ef9-9387-ab9fdd4673ff)

------

### Задание 2

1. Создайте файл count-vm.tf. Опишите в нём создание двух **одинаковых** ВМ  web-1 и web-2 (не web-0 и web-1) с минимальными параметрами, используя мета-аргумент **count loop**. Назначьте ВМ созданную в первом задании группу безопасности.(как это сделать узнайте в документации провайдера yandex/compute_instance )
2. Создайте файл for_each-vm.tf. Опишите в нём создание двух ВМ для баз данных с именами "main" и "replica" **разных** по cpu/ram/disk_volume , используя мета-аргумент **for_each loop**. Используйте для обеих ВМ одну общую переменную типа:
```
variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number }))
}
```  
При желании внесите в переменную все возможные параметры.

4. ВМ из пункта 2.1 должны создаваться после создания ВМ из пункта 2.2.
5. Используйте функцию file в local-переменной для считывания ключа ~/.ssh/id_rsa.pub и его последующего использования в блоке metadata, взятому из ДЗ 2.
6. Инициализируйте проект, выполните код.

### Решение 2

1. Создал файл count-vm.tf,объявил переменную web_base и sec_group(группа безопасности) В файле data.tf указал образ используемой ОС. 
   
![image](https://github.com/user-attachments/assets/b0835111-fb8b-4dbe-997c-7abb4438e5c7)

![image](https://github.com/user-attachments/assets/3db92a0b-2c8a-48bd-aeb7-262e361337d9)

![image](https://github.com/user-attachments/assets/df7dfda8-9c8c-44c3-8755-1f878a5d1836)

![image](https://github.com/user-attachments/assets/e22df5fc-0e59-432c-a7e5-f46a238749dd)

![image](https://github.com/user-attachments/assets/ccfae0f9-c488-4f33-96eb-e38c37153c13)



2. Создайте файл for_each-vm.tf. Опишите в нём создание двух ВМ для баз данных с именами "main" и "replica" ......

![image](https://github.com/user-attachments/assets/3be89cbd-d375-402f-baf2-3f6902d35136)


ВМ из пункта 2.1 должны создаваться после создания ВМ из пункта 2.2. Создаются ВМ "main" и "replica" файл for_each-vm.tf, затем web-1 и web-2. В count-vm.tf добавил  параметр depends_on = [yandex_compute_instance.db_server]

![image](https://github.com/user-attachments/assets/8f194893-316f-49dc-8de6-90a09d932fce)

![image](https://github.com/user-attachments/assets/c713cf1b-baa5-4451-ba43-98fce3da9960)

![image](https://github.com/user-attachments/assets/46f32fec-cda0-4b4f-af72-d2a03a5cf862)

![image](https://github.com/user-attachments/assets/f8108f17-cfaf-4ebc-b790-31795ac7f25c)

![image](https://github.com/user-attachments/assets/ae92b79b-aa1c-43c6-9809-80da5d577ab8)

![image](https://github.com/user-attachments/assets/96321aee-d3d8-4c2e-816e-1c7253e1b466)

------

### Задание 3

1. Создайте 3 одинаковых виртуальных диска размером 1 Гб с помощью ресурса yandex_compute_disk и мета-аргумента count в файле **disk_vm.tf** .
2. Создайте в том же файле **одиночную**(использовать count или for_each запрещено из-за задания №4) ВМ c именем "storage"  . Используйте блок **dynamic secondary_disk{..}** и мета-аргумент for_each для подключения созданных вами дополнительных дисков.

### Решение 3

![image](https://github.com/user-attachments/assets/92d8b580-3e63-494e-9a02-c20c36b5887e)

![image](https://github.com/user-attachments/assets/dbf9651b-3c3f-4ca6-9896-115b24ab142e)

![image](https://github.com/user-attachments/assets/4f488f95-d198-48ee-89be-c9f8ba3fd7e2)

![image](https://github.com/user-attachments/assets/8e0a7144-f0f1-43f5-b140-a5bd5d787ad5)

------

### Задание 4

1. В файле ansible.tf создайте inventory-файл для ansible.
Используйте функцию tepmplatefile и файл-шаблон для создания ansible inventory-файла из лекции.
Готовый код возьмите из демонстрации к лекции [**demonstration2**](https://github.com/netology-code/ter-homeworks/tree/main/03/demo).
Передайте в него в качестве переменных группы виртуальных машин из задания 2.1, 2.2 и 3.2, т. е. 5 ВМ.
2. Инвентарь должен содержать 3 группы и быть динамическим, т. е. обработать как группу из 2-х ВМ, так и 999 ВМ.
3. Добавьте в инвентарь переменную  [**fqdn**](https://cloud.yandex.ru/docs/compute/concepts/network#hostname).
``` 
[webservers]
web-1 ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>
web-2 ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>

[databases]
main ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>
replica ansible_host<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>

[storage]
storage ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>
```
Пример fqdn: ```web1.ru-central1.internal```(в случае указания переменной hostname(не путать с переменной name)); ```fhm8k1oojmm5lie8i22a.auto.internal```(в случае отсутвия перменной hostname - автоматическая генерация имени,  зона изменяется на auto). нужную вам переменную найдите в документации провайдера или terraform console.
4. Выполните код. Приложите скриншот получившегося файла. 

Для общего зачёта создайте в вашем GitHub-репозитории новую ветку terraform-03. Закоммитьте в эту ветку свой финальный код проекта, пришлите ссылку на коммит.   
**Удалите все созданные ресурсы**.

### Решение 4

![image](https://github.com/user-attachments/assets/5aaea1ac-8138-4456-abb9-1e862b3bc27d)

![image](https://github.com/user-attachments/assets/81f7f677-87aa-49f2-9892-9f8b04ab0fd6)

### Доработка

Переделал все файлы согласно оставленным комментам в коммитах

Код отрабатывает

![image](https://github.com/user-attachments/assets/39a36505-77b3-438a-af5a-946238185265)

создаются в начале main и replica, затем web1 и web2

web1 и web2 в группе безопасности example_dynamic, остальные в дефолтной

![image](https://github.com/user-attachments/assets/bd6c34fa-208c-499a-b9ef-c89df3b52266)

![image](https://github.com/user-attachments/assets/7e590a4a-8294-43f1-8fe7-12414ecb29f2)


три диска у storage

![image](https://github.com/user-attachments/assets/79beb7ab-e8d1-4e96-b188-88fb189639dc)

создается файл hosts.cfg (пока вывод не очень читаемый)

![image](https://github.com/user-attachments/assets/579c31ec-62ba-4590-ae4b-6dca95f650c0)


Поправил scr/count-vm.tf (ссылка на ресурс, ранее была ошибка т.к. указывал ID группы безопасности, которая менялась каждый раз при запуске)

![image](https://github.com/user-attachments/assets/34a15716-73fc-444d-8b91-b5fa5cd80ae8)

Убрал весь хардкор в scr/disk_vm.tf, вынес переменные отдельно

![image](https://github.com/user-attachments/assets/4dd20f6b-b5a2-4d55-8cb0-36c677e9ee09)


файл scr/hosts.tftpl  поправил

![image](https://github.com/user-attachments/assets/9a6fadf9-5087-4732-b762-68e705ed85e4)


в scr/locals.tf вынес переменные, оставил только 

![image](https://github.com/user-attachments/assets/8c56ef4f-0c1c-44d1-afc7-be2eb84e4f2a)

в scr/variables.tf убрал ssh-keys и переменую безопасности 

новые файлы 










------
