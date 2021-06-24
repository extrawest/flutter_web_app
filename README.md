# Extrawest Flutter Sample Web App

Flutter Sample Web App

## 1. Getting started
In order to use this template in your project, do the following step-by-step:

**1. Clone this repo to your folder:**

`git clone https://github.com/extrawest/*.git`

**2. Change directory to the previously cloned folder**

`cd */`

**3. Remove an existing .git folder**

`rm -rf .git `

**4. Initialize an empty folder with git**

`git init`

**5. Set remote url to your empty repository**

`git remote set-url origin https://github.com/extrawest/*.git`

**6. Add all files to git**

`git add .`

**7. Commit all the files with 'initial commit' commit message**

`git commit -m "added an existing project"`

**8. Push to remote repository**

`git push -u origin master`

### Change the app name, package name and bundleId (Android & iOS)
**For Android**
1. Modify **the package name** in your MainActivity.java/kt file
2. Modify **the directory** containing your MainActivity.java/kt file

`<project-name>/android/app/src/main/java/your/package/name`

3. Modify **the package name in manifest tag** and **the android:label value** in your **main, debug and profile** AndroidManifest.xml files
4. Modify **the applicationId** in your build.gradle file


**For iOS**

Change the **CFBundleIdentifier and CFBundleName** from your Info.plist file inside your ios/Runner directory.

```
<key>CFBundleIdentifier</key>
<string>com.your.packagename</string>
<key>CFBundleName</key>
<string>New Application Name</string>
```

## Implemented Features
- BLoC state sharing and state managing solution
- Responsive design implementation
- Screen Type Layout based widgets
- Support for displaying Web Images
- API client configuration with mock data and real endpoint
- Master-Detail pattern implementation
- Emulation of server requests
- Codemagic CI/CD service integration via codemagic.yaml
- Fluro navigation:
    - Simple route navigation
    - Function handlers (map to a function instead of a route)
    - Wildcard parameter matching
    - Querystring parameter parsing
    - Common transitions built-in
    - Simple custom transition creation

## Contribution
    - Fork it!
    - Create your feature branch: git checkout -b my-new-feature
    - Commit your changes: git commit -am 'Added some feature'
    - Push to the branch: git push origin my-new-feature
    - Submit a pull request.
---
Created by Extrawest Mobile Team
[Extrawest.com](https://www.extrawest.com), 2021
---
