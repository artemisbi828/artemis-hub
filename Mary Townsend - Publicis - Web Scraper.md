
Publicis\Lilly
Service
Mary T Bourke (QA Manager) <-- Annie Kim 
	• 3 Traffickers
Investment Team

```
[Investment Team] --> [Traffic Sheet + Jira Tix] --> QA Manager --> [QA Workbook + Jira Ticket] --> [Trafficker]

[Trafficker] --> [QA Manager] --> Tags/Code Pixels

Amazon -- no 3rd party pixels

Rejection to Investment Team b/c no creatives -- needs to go to Innvoid/DCM to use tools to check what creatives look like
```

[http://34.135.129.152:8501/?client=demo-client](http://34.135.129.152:8501/?client=demo-client)
# Terminal Log Session
```
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.8.0-1043-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Fri Dec  5 08:41:25 UTC 2025

  System load:  0.0               Processes:             123
  Usage of /:   29.6% of 9.51GB   Users logged in:       1
  Memory usage: 2%                IPv4 address for ens4: 10.128.0.2
  Swap usage:   0%

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

Expanded Security Maintenance for Applications is not enabled.

19 updates can be applied immediately.
16 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status

New release '24.04.3 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


Last login: Fri Dec  5 08:18:38 2025 from 35.235.244.32
jonas_pascua_artemis_bi_com@antigravity-box:~$ ls -1 ~/client-bridge/service_account.json
ls: cannot access '/home/jonas_pascua_artemis_bi_com/client-bridge/service_account.json': No such file or directory
jonas_pascua_artemis_bi_com@antigravity-box:~$ ^C
jonas_pascua_artemis_bi_com@antigravity-box:~$ ls -1 ~/*.json
ls: cannot access '/home/jonas_pascua_artemis_bi_com/*.json': No such file or directory
jonas_pascua_artemis_bi_com@antigravity-box:~$ mv ~/service_account.json ~/client-bridge/
mv: cannot move '/home/jonas_pascua_artemis_bi_com/service_account.json' to '/home/jonas_pascua_artemis_bi_com/client-bridge/': Not a directory
jonas_pascua_artemis_bi_com@antigravity-box:~$ cd ~
git clone https://github.com/artemisBI/client-bridge.git client-bridge
Cloning into 'client-bridge'...
Username for 'https://github.com': artemisBI
Password for 'https://artemisBI@github.com': 
remote: Enumerating objects: 28, done.
remote: Counting objects: 100% (28/28), done.
remote: Compressing objects: 100% (25/25), done.
remote: Total 28 (delta 4), reused 27 (delta 3), pack-reused 0 (from 0)
Receiving objects: 100% (28/28), 15.66 KiB | 15.66 MiB/s, done.
Resolving deltas: 100% (4/4), done.
jonas_pascua_artemis_bi_com@antigravity-box:~$ mv ~/service_account.json ~/client-bridge/
jonas_pascua_artemis_bi_com@antigravity-box:~$ mkdir -p ~/client-bridge/.streamlit
jonas_pascua_artemis_bi_com@antigravity-box:~$ mv ~/secrets.toml ~/client-bridge/.streamlit/
jonas_pascua_artemis_bi_com@antigravity-box:~$ cd ~/client-bridge
jonas_pascua_artemis_bi_com@antigravity-box:~/client-bridge$ source venv/bin/activate
-bash: venv/bin/activate: No such file or directory
jonas_pascua_artemis_bi_com@antigravity-box:~/client-bridge$ python3 -m venv venv
jonas_pascua_artemis_bi_com@antigravity-box:~/client-bridge$ source venv/bin/activate
(venv) jonas_pascua_artemis_bi_com@antigravity-box:~/client-bridge$ streamlit run app.py
streamlit: command not found
(venv) jonas_pascua_artemis_bi_com@antigravity-box:~/client-bridge$ pip install -r requirements.txt
pip install -e ../shared-utils
ERROR: ../../shared-utils is not a valid editable requirement. It should either be a path to a local project or a VCS URL (beginning with bzr+http, bzr+https, bzr+ssh, bzr+sftp, bzr+ftp, bzr+lp, bzr+file, git+http, git+https, git+ssh, git+git, git+file, hg+file, hg+http, hg+https, hg+ssh, hg+static-http, svn+ssh, svn+http, svn+https, svn+svn, svn+file).
Obtaining file:///home/jonas_pascua_artemis_bi_com/shared-utils
  Installing build dependencies ... done
  Checking if build backend supports build_editable ... done
  Getting requirements to build editable ... done
  Preparing editable metadata (pyproject.toml) ... done
Collecting google-api-python-client
  Downloading google_api_python_client-2.187.0-py3-none-any.whl (14.6 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 14.6/14.6 MB 29.5 MB/s eta 0:00:00
Collecting beautifulsoup4
  Downloading beautifulsoup4-4.14.3-py3-none-any.whl (107 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 107.7/107.7 KB 14.8 MB/s eta 0:00:00
Collecting streamlit
  Downloading streamlit-1.52.0-py3-none-any.whl (9.0 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 9.0/9.0 MB 55.6 MB/s eta 0:00:00
Collecting google-cloud-firestore
  Downloading google_cloud_firestore-2.21.0-py3-none-any.whl (368 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 368.8/368.8 KB 37.6 MB/s eta 0:00:00
Collecting google-auth
  Downloading google_auth-2.43.0-py2.py3-none-any.whl (223 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 223.1/223.1 KB 20.7 MB/s eta 0:00:00
Collecting soupsieve>=1.6.1
  Downloading soupsieve-2.8-py3-none-any.whl (36 kB)
Collecting typing-extensions>=4.0.0
  Downloading typing_extensions-4.15.0-py3-none-any.whl (44 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 44.6/44.6 KB 6.3 MB/s eta 0:00:00
Collecting google-api-core!=2.0.*,!=2.1.*,!=2.2.*,!=2.3.0,<3.0.0,>=1.31.5
  Downloading google_api_core-2.28.1-py3-none-any.whl (173 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 173.7/173.7 KB 24.4 MB/s eta 0:00:00
Collecting google-auth-httplib2<1.0.0,>=0.2.0
  Downloading google_auth_httplib2-0.2.1-py3-none-any.whl (9.5 kB)
Collecting uritemplate<5,>=3.0.1
  Downloading uritemplate-4.2.0-py3-none-any.whl (11 kB)
Collecting httplib2<1.0.0,>=0.19.0
  Downloading httplib2-0.31.0-py3-none-any.whl (91 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 91.1/91.1 KB 13.8 MB/s eta 0:00:00
Collecting cachetools<7.0,>=2.0.0
  Downloading cachetools-6.2.2-py3-none-any.whl (11 kB)
Collecting rsa<5,>=3.1.4
  Downloading rsa-4.9.1-py3-none-any.whl (34 kB)
Collecting pyasn1-modules>=0.2.1
  Downloading pyasn1_modules-0.4.2-py3-none-any.whl (181 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 181.3/181.3 KB 22.0 MB/s eta 0:00:00
Collecting google-cloud-core<3.0.0,>=1.4.1
  Downloading google_cloud_core-2.5.0-py3-none-any.whl (29 kB)
Collecting proto-plus<2.0.0,>=1.22.0
  Downloading proto_plus-1.26.1-py3-none-any.whl (50 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 50.2/50.2 KB 7.7 MB/s eta 0:00:00
Collecting protobuf!=3.20.0,!=3.20.1,!=4.21.0,!=4.21.1,!=4.21.2,!=4.21.3,!=4.21.4,!=4.21.5,<7.0.0dev,>=3.20.2
  Downloading protobuf-6.33.1-cp39-abi3-manylinux2014_x86_64.whl (323 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 323.2/323.2 KB 30.9 MB/s eta 0:00:00
Collecting pyarrow>=7.0
  Downloading pyarrow-22.0.0-cp310-cp310-manylinux_2_28_x86_64.whl (47.6 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 47.6/47.6 MB 24.1 MB/s eta 0:00:00
Collecting tenacity<10,>=8.1.0
  Downloading tenacity-9.1.2-py3-none-any.whl (28 kB)
Collecting altair!=5.4.0,!=5.4.1,<7,>=4.0
  Downloading altair-6.0.0-py3-none-any.whl (795 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 795.4/795.4 KB 54.2 MB/s eta 0:00:00
Collecting click<9,>=7.0
  Downloading click-8.3.1-py3-none-any.whl (108 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 108.3/108.3 KB 16.8 MB/s eta 0:00:00
Collecting gitpython!=3.1.19,<4,>=3.0.7
  Downloading gitpython-3.1.45-py3-none-any.whl (208 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 208.2/208.2 KB 26.9 MB/s eta 0:00:00
Collecting pydeck<1,>=0.8.0b4
  Downloading pydeck-0.9.1-py2.py3-none-any.whl (6.9 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 6.9/6.9 MB 132.7 MB/s eta 0:00:00
Collecting tornado!=6.5.0,<7,>=6.0.3
  Downloading tornado-6.5.2-cp39-abi3-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl (443 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 443.9/443.9 KB 43.9 MB/s eta 0:00:00
Collecting blinker<2,>=1.5.0
  Downloading blinker-1.9.0-py3-none-any.whl (8.5 kB)
Collecting requests<3,>=2.27
  Downloading requests-2.32.5-py3-none-any.whl (64 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 64.7/64.7 KB 10.0 MB/s eta 0:00:00
Collecting numpy<3,>=1.23
  Downloading numpy-2.2.6-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (16.8 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 16.8/16.8 MB 82.2 MB/s eta 0:00:00
Collecting toml<2,>=0.10.1
  Downloading toml-0.10.2-py2.py3-none-any.whl (16 kB)
Collecting pillow<13,>=7.1.0
  Downloading pillow-12.0.0-cp310-cp310-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl (7.0 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 7.0/7.0 MB 108.9 MB/s eta 0:00:00
Collecting pandas<3,>=1.4.0
  Downloading pandas-2.3.3-cp310-cp310-manylinux_2_24_x86_64.manylinux_2_28_x86_64.whl (12.8 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 12.8/12.8 MB 96.6 MB/s eta 0:00:00
Collecting packaging>=20
  Downloading packaging-25.0-py3-none-any.whl (66 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 66.5/66.5 KB 6.0 MB/s eta 0:00:00
Collecting watchdog<7,>=2.1.5
  Downloading watchdog-6.0.0-py3-none-manylinux2014_x86_64.whl (79 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 79.1/79.1 KB 10.5 MB/s eta 0:00:00
Collecting narwhals>=1.27.1
  Downloading narwhals-2.13.0-py3-none-any.whl (426 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 426.4/426.4 KB 37.4 MB/s eta 0:00:00
Collecting jsonschema>=3.0
  Downloading jsonschema-4.25.1-py3-none-any.whl (90 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 90.0/90.0 KB 10.6 MB/s eta 0:00:00
Collecting jinja2
  Downloading jinja2-3.1.6-py3-none-any.whl (134 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 134.9/134.9 KB 16.0 MB/s eta 0:00:00
Collecting gitdb<5,>=4.0.1
  Downloading gitdb-4.0.12-py3-none-any.whl (62 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 62.8/62.8 KB 8.1 MB/s eta 0:00:00
Collecting googleapis-common-protos<2.0.0,>=1.56.2
  Downloading googleapis_common_protos-1.72.0-py3-none-any.whl (297 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 297.5/297.5 KB 24.8 MB/s eta 0:00:00
Collecting grpcio-status<2.0.0,>=1.33.2
  Downloading grpcio_status-1.76.0-py3-none-any.whl (14 kB)
Collecting grpcio<2.0.0,>=1.33.2
  Downloading grpcio-1.76.0-cp310-cp310-manylinux2014_x86_64.manylinux_2_17_x86_64.whl (6.6 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 6.6/6.6 MB 101.3 MB/s eta 0:00:00
Collecting pyparsing<4,>=3.0.4
  Downloading pyparsing-3.2.5-py3-none-any.whl (113 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 113.9/113.9 KB 16.9 MB/s eta 0:00:00
Collecting python-dateutil>=2.8.2
  Downloading python_dateutil-2.9.0.post0-py2.py3-none-any.whl (229 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 229.9/229.9 KB 25.4 MB/s eta 0:00:00
Collecting tzdata>=2022.7
  Downloading tzdata-2025.2-py2.py3-none-any.whl (347 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 347.8/347.8 KB 35.8 MB/s eta 0:00:00
Collecting pytz>=2020.1
  Downloading pytz-2025.2-py2.py3-none-any.whl (509 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 509.2/509.2 KB 43.2 MB/s eta 0:00:00
Collecting pyasn1<0.7.0,>=0.6.1
  Downloading pyasn1-0.6.1-py3-none-any.whl (83 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 83.1/83.1 KB 11.9 MB/s eta 0:00:00
Collecting charset_normalizer<4,>=2
  Downloading charset_normalizer-3.4.4-cp310-cp310-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl (153 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 153.6/153.6 KB 21.7 MB/s eta 0:00:00
Collecting urllib3<3,>=1.21.1
  Downloading urllib3-2.5.0-py3-none-any.whl (129 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 129.8/129.8 KB 18.8 MB/s eta 0:00:00
Collecting certifi>=2017.4.17
  Downloading certifi-2025.11.12-py3-none-any.whl (159 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 159.4/159.4 KB 20.5 MB/s eta 0:00:00
Collecting idna<4,>=2.5
  Downloading idna-3.11-py3-none-any.whl (71 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 71.0/71.0 KB 10.6 MB/s eta 0:00:00
Collecting smmap<6,>=3.0.1
  Downloading smmap-5.0.2-py3-none-any.whl (24 kB)
Collecting MarkupSafe>=2.0
  Downloading markupsafe-3.0.3-cp310-cp310-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl (20 kB)
Collecting rpds-py>=0.7.1
  Downloading rpds_py-0.30.0-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (390 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 390.5/390.5 KB 39.1 MB/s eta 0:00:00
Collecting jsonschema-specifications>=2023.03.6
  Downloading jsonschema_specifications-2025.9.1-py3-none-any.whl (18 kB)
Collecting attrs>=22.2.0
  Downloading attrs-25.4.0-py3-none-any.whl (67 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 67.6/67.6 KB 8.6 MB/s eta 0:00:00
Collecting referencing>=0.28.4
  Downloading referencing-0.37.0-py3-none-any.whl (26 kB)
Collecting six>=1.5
  Downloading six-1.17.0-py2.py3-none-any.whl (11 kB)
Building wheels for collected packages: shared_utils
  Building editable for shared_utils (pyproject.toml) ... done
  Created wheel for shared_utils: filename=shared_utils-0.1.0-0.editable-py3-none-any.whl size=2894 sha256=737c4fe40d96b6328a4f1ef24ddf471b1588c9732deeb0b7d2ae821875a66003
  Stored in directory: /tmp/pip-ephem-wheel-cache-olkqt7dp/wheels/97/51/9e/196bbfd601708e9315cf86d09a76dac74e21857ab8031467df
Successfully built shared_utils
Installing collected packages: pytz, watchdog, urllib3, uritemplate, tzdata, typing-extensions, tornado, toml, tenacity, soupsieve, smmap, six, rpds-py, pyparsing, pyasn1, pyarrow, protobuf, pillow, packaging, numpy, narwhals, MarkupSafe, idna, click, charset_normalizer, certifi, cachetools, blinker, attrs, rsa, requests, referencing, python-dateutil, pyasn1-modules, proto-plus, jinja2, httplib2, grpcio, googleapis-common-protos, gitdb, beautifulsoup4, pydeck, pandas, jsonschema-specifications, grpcio-status, google-auth, gitpython, jsonschema, google-auth-httplib2, google-api-core, google-cloud-core, google-api-python-client, altair, streamlit, google-cloud-firestore, shared_utils
Successfully installed MarkupSafe-3.0.3 altair-6.0.0 attrs-25.4.0 beautifulsoup4-4.14.3 blinker-1.9.0 cachetools-6.2.2 certifi-2025.11.12 charset_normalizer-3.4.4 click-8.3.1 gitdb-4.0.12 gitpython-3.1.45 google-api-core-2.28.1 google-api-python-client-2.187.0 google-auth-2.43.0 google-auth-httplib2-0.2.1 google-cloud-core-2.5.0 google-cloud-firestore-2.21.0 googleapis-common-protos-1.72.0 grpcio-1.76.0 grpcio-status-1.76.0 httplib2-0.31.0 idna-3.11 jinja2-3.1.6 jsonschema-4.25.1 jsonschema-specifications-2025.9.1 narwhals-2.13.0 numpy-2.2.6 packaging-25.0 pandas-2.3.3 pillow-12.0.0 proto-plus-1.26.1 protobuf-6.33.1 pyarrow-22.0.0 pyasn1-0.6.1 pyasn1-modules-0.4.2 pydeck-0.9.1 pyparsing-3.2.5 python-dateutil-2.9.0.post0 pytz-2025.2 referencing-0.37.0 requests-2.32.5 rpds-py-0.30.0 rsa-4.9.1 shared_utils-0.1.0 six-1.17.0 smmap-5.0.2 soupsieve-2.8 streamlit-1.52.0 tenacity-9.1.2 toml-0.10.2 tornado-6.5.2 typing-extensions-4.15.0 tzdata-2025.2 uritemplate-4.2.0 urllib3-2.5.0 watchdog-6.0.0
(venv) jonas_pascua_artemis_bi_com@antigravity-box:~/client-bridge$ streamlit run app.py

Collecting usage statistics. To deactivate, set browser.gatherUsageStats to false.


  You can now view your Streamlit app in your browser.

  Local URL: http://localhost:8501
  Network URL: http://10.128.0.2:8501
  External URL: http://34.68.114.33:8501

^C  Stopping...
(venv) jonas_pascua_artemis_bi_com@antigravity-box:~/client-bridge$ ^C
(venv) jonas_pascua_artemis_bi_com@antigravity-box:~/client-bridge$ streamlit run app.py

Collecting usage statistics. To deactivate, set browser.gatherUsageStats to false.


  You can now view your Streamlit app in your browser.

  Local URL: http://localhost:8501
  Network URL: http://10.128.0.2:8501
  External URL: http://34.68.114.33:8501

/home/jonas_pascua_artemis_bi_com/client-bridge/venv/lib/python3.10/site-packages/google/api_core/_python_version_support.py:266: FutureWarning: You are using a Python version (3.10.12) which Google will stop supporting in new releases of google.api_core once it reaches its end of life (2026-10-04). Please upgrade to the latest Python version, or at least Python 3.11, to continue receiving updates for google.api_core past that date.
  warnings.warn(message, FutureWarning)
2025-12-05 08:52:15.965 Uncaught app execution
Traceback (most recent call last):
  File "/home/jonas_pascua_artemis_bi_com/client-bridge/venv/lib/python3.10/site-packages/streamlit/runtime/scriptrunner/exec_code.py", line 129, in exec_func_with_error_handling
    result = func()
  File "/home/jonas_pascua_artemis_bi_com/client-bridge/venv/lib/python3.10/site-packages/streamlit/runtime/scriptrunner/script_runner.py", line 671, in code_to_exec
    exec(code, module.__dict__)  # noqa: S102
  File "/home/jonas_pascua_artemis_bi_com/client-bridge/app.py", line 2, in <module>
    from components import file_manager, chat, annotator
  File "/home/jonas_pascua_artemis_bi_com/client-bridge/components/annotator.py", line 2, in <module>
    from streamlit_drawable_canvas import st_canvas
ModuleNotFoundError: No module named 'streamlit_drawable_canvas'
^C  Stopping...
(venv) jonas_pascua_artemis_bi_com@antigravity-box:~/client-bridge$ pip install streamlit-drawable-canvas pandas watchdog beautifulsoup4
Collecting streamlit-drawable-canvas
  Downloading streamlit_drawable_canvas-0.9.3-py3-none-any.whl (1.2 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.2/1.2 MB 8.7 MB/s eta 0:00:00
Requirement already satisfied: pandas in ./venv/lib/python3.10/site-packages (2.3.3)
Requirement already satisfied: watchdog in ./venv/lib/python3.10/site-packages (6.0.0)
Requirement already satisfied: beautifulsoup4 in ./venv/lib/python3.10/site-packages (4.14.3)
Requirement already satisfied: numpy in ./venv/lib/python3.10/site-packages (from streamlit-drawable-canvas) (2.2.6)
Requirement already satisfied: Pillow in ./venv/lib/python3.10/site-packages (from streamlit-drawable-canvas) (12.0.0)
Requirement already satisfied: streamlit>=0.63 in ./venv/lib/python3.10/site-packages (from streamlit-drawable-canvas) (1.52.0)
Requirement already satisfied: python-dateutil>=2.8.2 in ./venv/lib/python3.10/site-packages (from pandas) (2.9.0.post0)
Requirement already satisfied: pytz>=2020.1 in ./venv/lib/python3.10/site-packages (from pandas) (2025.2)
Requirement already satisfied: tzdata>=2022.7 in ./venv/lib/python3.10/site-packages (from pandas) (2025.2)
Requirement already satisfied: soupsieve>=1.6.1 in ./venv/lib/python3.10/site-packages (from beautifulsoup4) (2.8)
Requirement already satisfied: typing-extensions>=4.0.0 in ./venv/lib/python3.10/site-packages (from beautifulsoup4) (4.15.0)
Requirement already satisfied: six>=1.5 in ./venv/lib/python3.10/site-packages (from python-dateutil>=2.8.2->pandas) (1.17.0)
Requirement already satisfied: pyarrow>=7.0 in ./venv/lib/python3.10/site-packages (from streamlit>=0.63->streamlit-drawable-canvas) (22.0.0)
Requirement already satisfied: requests<3,>=2.27 in ./venv/lib/python3.10/site-packages (from streamlit>=0.63->streamlit-drawable-canvas) (2.32.5)
Requirement already satisfied: altair!=5.4.0,!=5.4.1,<7,>=4.0 in ./venv/lib/python3.10/site-packages (from streamlit>=0.63->streamlit-drawable-canvas) (6.0.0)
Requirement already satisfied: blinker<2,>=1.5.0 in ./venv/lib/python3.10/site-packages (from streamlit>=0.63->streamlit-drawable-canvas) (1.9.0)
Requirement already satisfied: gitpython!=3.1.19,<4,>=3.0.7 in ./venv/lib/python3.10/site-packages (from streamlit>=0.63->streamlit-drawable-canvas) (3.1.45)
Requirement already satisfied: pydeck<1,>=0.8.0b4 in ./venv/lib/python3.10/site-packages (from streamlit>=0.63->streamlit-drawable-canvas) (0.9.1)
Requirement already satisfied: tornado!=6.5.0,<7,>=6.0.3 in ./venv/lib/python3.10/site-packages (from streamlit>=0.63->streamlit-drawable-canvas) (6.5.2)
Requirement already satisfied: toml<2,>=0.10.1 in ./venv/lib/python3.10/site-packages (from streamlit>=0.63->streamlit-drawable-canvas) (0.10.2)
Requirement already satisfied: protobuf<7,>=3.20 in ./venv/lib/python3.10/site-packages (from streamlit>=0.63->streamlit-drawable-canvas) (6.33.1)
Requirement already satisfied: packaging>=20 in ./venv/lib/python3.10/site-packages (from streamlit>=0.63->streamlit-drawable-canvas) (25.0)
Requirement already satisfied: cachetools<7,>=4.0 in ./venv/lib/python3.10/site-packages (from streamlit>=0.63->streamlit-drawable-canvas) (6.2.2)
Requirement already satisfied: tenacity<10,>=8.1.0 in ./venv/lib/python3.10/site-packages (from streamlit>=0.63->streamlit-drawable-canvas) (9.1.2)
Requirement already satisfied: click<9,>=7.0 in ./venv/lib/python3.10/site-packages (from streamlit>=0.63->streamlit-drawable-canvas) (8.3.1)
Requirement already satisfied: narwhals>=1.27.1 in ./venv/lib/python3.10/site-packages (from altair!=5.4.0,!=5.4.1,<7,>=4.0->streamlit>=0.63->streamlit-drawable-canvas) (2.13.0)
Requirement already satisfied: jsonschema>=3.0 in ./venv/lib/python3.10/site-packages (from altair!=5.4.0,!=5.4.1,<7,>=4.0->streamlit>=0.63->streamlit-drawable-canvas) (4.25.1)
Requirement already satisfied: jinja2 in ./venv/lib/python3.10/site-packages (from altair!=5.4.0,!=5.4.1,<7,>=4.0->streamlit>=0.63->streamlit-drawable-canvas) (3.1.6)
Requirement already satisfied: gitdb<5,>=4.0.1 in ./venv/lib/python3.10/site-packages (from gitpython!=3.1.19,<4,>=3.0.7->streamlit>=0.63->streamlit-drawable-canvas) (4.0.12)
Requirement already satisfied: charset_normalizer<4,>=2 in ./venv/lib/python3.10/site-packages (from requests<3,>=2.27->streamlit>=0.63->streamlit-drawable-canvas) (3.4.4)
Requirement already satisfied: idna<4,>=2.5 in ./venv/lib/python3.10/site-packages (from requests<3,>=2.27->streamlit>=0.63->streamlit-drawable-canvas) (3.11)
Requirement already satisfied: certifi>=2017.4.17 in ./venv/lib/python3.10/site-packages (from requests<3,>=2.27->streamlit>=0.63->streamlit-drawable-canvas) (2025.11.12)
Requirement already satisfied: urllib3<3,>=1.21.1 in ./venv/lib/python3.10/site-packages (from requests<3,>=2.27->streamlit>=0.63->streamlit-drawable-canvas) (2.5.0)
Requirement already satisfied: smmap<6,>=3.0.1 in ./venv/lib/python3.10/site-packages (from gitdb<5,>=4.0.1->gitpython!=3.1.19,<4,>=3.0.7->streamlit>=0.63->streamlit-drawable-canvas) (5.0.2)
Requirement already satisfied: MarkupSafe>=2.0 in ./venv/lib/python3.10/site-packages (from jinja2->altair!=5.4.0,!=5.4.1,<7,>=4.0->streamlit>=0.63->streamlit-drawable-canvas) (3.0.3)
Requirement already satisfied: referencing>=0.28.4 in ./venv/lib/python3.10/site-packages (from jsonschema>=3.0->altair!=5.4.0,!=5.4.1,<7,>=4.0->streamlit>=0.63->streamlit-drawable-canvas) (0.37.0)
Requirement already satisfied: rpds-py>=0.7.1 in ./venv/lib/python3.10/site-packages (from jsonschema>=3.0->altair!=5.4.0,!=5.4.1,<7,>=4.0->streamlit>=0.63->streamlit-drawable-canvas) (0.30.0)
Requirement already satisfied: jsonschema-specifications>=2023.03.6 in ./venv/lib/python3.10/site-packages (from jsonschema>=3.0->altair!=5.4.0,!=5.4.1,<7,>=4.0->streamlit>=0.63->streamlit-drawable-canvas) (2025.9.1)
Requirement already satisfied: attrs>=22.2.0 in ./venv/lib/python3.10/site-packages (from jsonschema>=3.0->altair!=5.4.0,!=5.4.1,<7,>=4.0->streamlit>=0.63->streamlit-drawable-canvas) (25.4.0)
Installing collected packages: streamlit-drawable-canvas
Successfully installed streamlit-drawable-canvas-0.9.3
(venv) jonas_pascua_artemis_bi_com@antigravity-box:~/client-bridge$ streamlit run app.py

Collecting usage statistics. To deactivate, set browser.gatherUsageStats to false.


  You can now view your Streamlit app in your browser.

  Local URL: http://localhost:8501
  Network URL: http://10.128.0.2:8501
  External URL: http://34.68.114.33:8501

```