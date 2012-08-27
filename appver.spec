%define buildroot %{_topdir}/%{name}-%{version}-root
%define APP_BUILD_DATE %(date +'%%Y%%m%%d_%%H%%M')

Name:       appver
Summary:    smart way how to handle versions
Version:    1.0.0
Release:    1
Group:      System/Libraries
License:    LGPL v2.1
BuildArch:  noarch
URL:        https://github.com/safrm/appver
Vendor:     Miroslav Safr <miroslav.safr@gmail.com>
Source0:    %{name}-%{version}.tar.bz2
Autoreq: on
Autoreqprov: on
BuildRoot: %{buildroot}

%description
smart way how to handle versions



%prep
%setup -c -n ./%{name}-%{version}
# >> setup
# << setup

%build
# >> build pre
# << build pre

# >> build post
# << build post

%install
rm -fr $RPM_BUILD_ROOT
# >> install pre
export INSTALL_ROOT=$RPM_BUILD_ROOT
# << install pre 
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_datadir}/doc/appver
install -m 755 ./appver %{buildroot}/usr/bin/
sed -i".bkp" "1,/^VERSION=/s/^VERSION=.*/VERSION=%{version}/" %{buildroot}%{_bindir}/appver && rm -f %{buildroot}%{_bindir}/appver.bkp
sed -i".bkp" "1,/^VERSION_DATE=/s/^VERSION_DATE=.*/VERSION_DATE=%{APP_BUILD_DATE}/" %{buildroot}%{_bindir}/appver && rm -f %{buildroot}%{_bindir}/appver.bkp
install -m 644 ./README %{buildroot}%{_datadir}/doc/appver
sed -i".bkp" "1,/Version: /s/Version:   */Version:   %{version}/"  %{buildroot}%{_datadir}/doc/appver/README && rm -f %{buildroot}%{_datadir}/doc/appver/README.bkp
install -m 644 ./LICENSE.LGPL %{buildroot}%{_datadir}/doc/appver

# >> install post
# << install post

%files
%defattr(-,root,root,-)
# >> files
%{_bindir}/appver
%{_datadir}/doc/appver/README
%{_datadir}/doc/appver/LICENSE.LGPL
# << files


