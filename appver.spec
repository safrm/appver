%define APP_BUILD_DATE %(date +'%%Y%%m%%d_%%H%%M')

Name:       appver
Summary:    smart way how to handle versions
Version:    1.0.0
Release:    1
Group:      Development/Tools
License:    LGPL v2.1
BuildArch:  noarch
URL:        http://safrm.net/projects/appver/
Vendor:     Miroslav Safr <miroslav.safr@gmail.com>
Source0:    %{name}-%{version}.tar.bz2
Autoreq: on
Autoreqprov: on
BuildRequires: libxslt
BuildRequires: docbook-xsl-stylesheets

%description
smart way how to handle versions

%prep
%setup -c -n ./%{name}-%{version}

%build
#rather avoid jenkins-support-scripts update because of cyclic deps
cd doc && ./update_docs.sh %{version} && cd -

%install
rm -fr %{buildroot}

mkdir -p %{buildroot}%{_bindir}
install -m 755 ./appver %{buildroot}/usr/bin/
sed -i".bkp" "1,/^VERSION=/s/^VERSION=.*/VERSION=%{version}/" %{buildroot}%{_bindir}/appver && rm -f %{buildroot}%{_bindir}/appver.bkp
sed -i".bkp" "1,/^VERSION_DATE=/s/^VERSION_DATE=.*/VERSION_DATE=%{APP_BUILD_DATE}/" %{buildroot}%{_bindir}/appver && rm -f %{buildroot}%{_bindir}/appver.bkp
install -d -m 755 %{buildroot}%{_mandir}/man1
install -m 644 ./doc/manpages/appver.1* %{buildroot}%{_mandir}/man1

%check
for TEST in $(  grep -r -l -h "#\!/bin/sh" . )
do
		sh -n $TEST
		if  [ $? != 0 ]; then
			echo "syntax error in $TEST, exiting.." 
			exit 1
		fi
done 

%files
%defattr(-,root,root,-)
%{_bindir}/appver
%{_mandir}/man1/appver.1*


