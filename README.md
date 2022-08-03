# HXToolAnsible
Ansible configuration to install HXTool on Debian 22.04 and RHEL9 based distributions. This has been tested with `generic/ubuntu2204` and `generic/centos9s` Vagrant boxes using virtualbox and the Vagrantfile is included within for testing purposes. This is not a complete solution as some distributions may vary and require different dependencies, this is a base to start from.

## HXTool License
I have no affiliation with HXTool and this is a personal project to deploy HXTool with Ansible and the name HXTool is only used `"in connection with or referring to the original Software that is not modified"`.

The following license applies to HXTool:

```
HXTool™ Software License 2.0


Copyright © 2017 - 2020 by FireEye, Inc. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files made available with this software (the "Software") to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

•	The above copyright notice, this permission notice, and the following provisions shall be included in all copies or substantial portions of the Software. 
•	You agree to be bound to any and all license provisions applicable to third-party software, if any, contained in the Software. 
•	You give the authors, copyright holder, and others the right to freely use any of your ideas, comments, suggestions, or modifications pertaining to the Software or its use that you choose to disclose. 
•	You shall not use the trade names, trademarks, service marks, or product names of the Licensor (including, without limitation, HXTool), except HXTool may be used (i) as required for reasonable and customary use in describing the origin of the Software, and (ii) in connection with or referring to the original Software that is not modified by you.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, TITLE, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY SUPPORT OR MAINTENANCE OF THE SOFTWARE, ITS INTEGRATION OR COMPATIBILITY WITH OTHER PRODUCTS, ANY ERROR, DEFECT OR VULNERABILITY IN THE SOFTWARE, OR ANY CLAIM, DAMAGES (INCLUDING BUT NOT LIMITED TO DIRECT, INDIRECT, SPECIAL, EXEMPLARY, INCIDENTAL, OR CONSEQUENTIAL DAMAGES OF ANY CHARACTER), OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OF, INABILITY TO USE OR OTHER DEALINGS IN THE SOFTWARE, EVEN IF ADVISED OF THE POSSBILITY OF SUCH DAMAGES. YOU ARE SOLELY RESPONSIBLE FOR DETERMINING THE APPROPRIATENESS OF USING OR DEALING IN THE SOFTWARE, AND ASSUME ANY RISKS ASSOCIATED WITH YOUR EXERCISE OF PERMISSIONS UNDER THIS LICENSE.  
Footer
```
## License

This project carries the Unlicense license in respect to the project itself. However, please note the HXTool license in regards to HXTool itself.

## Ansible
- OS is updated
- Dependencies are installed if required
- User account and group are made for HXTool
- HXTool is cloned from github master
- Python Virtualenv is created for HXTool
- Firewall is opened on RedHat based systems
- Service is installed

## Vagrant
Running `vagrant up` from the project directory brings up both Debian and RedHat boxes. The Debian box mounts host port 8081 to 8080 on the guest, the RedHat box mounts 8082 to 8080. Running `vagrant up debian` will bring only the debian box up; the same goes for `vagrant up redhat`, and ssh with `vagrant ssh`.

## To Do
- Implement Windows roles and Vagrantfile
- Implement other providers (VMWare, Hyper-V)
- Implement Packer to build virtual machines from scratch

## Notes
The following warning provided by HXTool is provided when running `hxtool.py` and this still remains true:

```
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
```
