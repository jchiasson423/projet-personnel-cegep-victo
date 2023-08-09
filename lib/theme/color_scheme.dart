import 'package:flutter/material.dart';

/// Couleurs du thème
class ThemeColors {
  /// Thème clair
  late final ColorScheme lightColorSheme;

  /// Thème sombre
  late final ColorScheme darkColorSheme;

  /// Constructeur du thème
  ThemeColors() {
    lightColorSheme = ColorScheme(
      brightness: Brightness.light,
      primary: lightprimary,
      onPrimary: lightonprimary,
      secondary: lightsecondary,
      onSecondary: lightonsecondary,
      error: lighterror,
      onError: lightonerror,
      background: lightbackground,
      onBackground: lightonbackground,
      surface: lightsurface,
      onSurface: lightonsurface,
      onSurfaceVariant: lightonsurfacevariant,
      secondaryContainer: lightsecondarycontainer,
      onSecondaryContainer: lightonsecondarycontainer,
      primaryContainer: lightprimarycontainer,
      onPrimaryContainer: lightonprimarycontainer,
      tertiary: lighttertiary,
      onTertiary: lightontertiary,
      tertiaryContainer: lighttertiarycontainer,
      onTertiaryContainer: lightontertiarycontainer,
      errorContainer: lighterrorcontainer,
      onErrorContainer: lightonerrorcontainer,
      surfaceVariant: lightsurfacevariant,
      outline: lightoutline,
      outlineVariant: lightoutlinevariant,
      inverseSurface: lightinversesurface,
      onInverseSurface: lightinverseonsurface,
      inversePrimary: lightinverseprimary,
      shadow: lightshadow,
      scrim: lightscrim,
      surfaceTint: lightsurfacetint,
    );

    darkColorSheme = ColorScheme(
      brightness: Brightness.dark,
      primary: darkprimary,
      onPrimary: darkonprimary,
      secondary: darksecondary,
      onSecondary: darkonsecondary,
      error: darkerror,
      onError: darkonerror,
      background: darkbackground,
      onBackground: darkonbackground,
      surface: darksurface,
      onSurface: darkonsurface,
      onSurfaceVariant: darkonsurfacevariant,
      secondaryContainer: darksecondarycontainer,
      onSecondaryContainer: darkonsecondarycontainer,
      primaryContainer: darkprimarycontainer,
      onPrimaryContainer: darkonprimarycontainer,
      tertiary: darktertiary,
      onTertiary: darkontertiary,
      tertiaryContainer: darktertiarycontainer,
      onTertiaryContainer: darkontertiarycontainer,
      errorContainer: darkerrorcontainer,
      onErrorContainer: darkonerrorcontainer,
      surfaceVariant: darksurfacevariant,
      outline: darkoutline,
      outlineVariant: darkoutlinevariant,
      inverseSurface: darkinversesurface,
      onInverseSurface: darkinverseonsurface,
      inversePrimary: darkinverseprimary,
      shadow: darkshadow,
      scrim: darkscrim,
      surfaceTint: darksurfacetint,
    );
  }

  final Color white = const Color(0xffffffff);
  final Color black = const Color(0xff000000);

  final Color lightprimary = const Color(0xff702bed);
  final Color lightonprimary = const Color(0xffffffff);
  final Color lightprimarycontainer = const Color(0xffe9ddff);
  final Color lightonprimarycontainer = const Color(0xff23005c);
  final Color lightprimaryfixed = const Color(0xffe9ddff);
  final Color lightonprimaryfixed = const Color(0xff23005c);
  final Color lightprimaryfixeddim = const Color(0xffd0bcff);
  final Color lightonprimaryfixedvariant = const Color(0xff5600ca);
  final Color lightsecondary = const Color(0xff0051df);
  final Color lightonsecondary = const Color(0xffffffff);
  final Color lightsecondarycontainer = const Color(0xffdbe1ff);
  final Color lightonsecondarycontainer = const Color(0xff00174c);
  final Color lightsecondaryfixed = const Color(0xffdbe1ff);
  final Color lightonsecondaryfixed = const Color(0xff00174c);
  final Color lightsecondaryfixeddim = const Color(0xffb5c4ff);
  final Color lightonsecondaryfixedvariant = const Color(0xff003dab);
  final Color lighttertiary = const Color(0xff6e37dc);
  final Color lightontertiary = const Color(0xffffffff);
  final Color lighttertiarycontainer = const Color(0xffe9ddff);
  final Color lightontertiarycontainer = const Color(0xff23005c);
  final Color lighttertiaryfixed = const Color(0xffe9ddff);
  final Color lightontertiaryfixed = const Color(0xff23005c);
  final Color lighttertiaryfixeddim = const Color(0xffd0bcff);
  final Color lightontertiaryfixedvariant = const Color(0xff560ec3);
  final Color lighterror = const Color(0xffc00011);
  final Color lightonerror = const Color(0xffffffff);
  final Color lighterrorcontainer = const Color(0xffffdad6);
  final Color lightonerrorcontainer = const Color(0xff410002);
  final Color lightoutline = const Color(0xff7a757f);
  final Color lightbackground = const Color(0xfffbfdf8);
  final Color lightonbackground = const Color(0xff191c1a);
  final Color lightsurface = const Color(0xfff8faf5);
  final Color lightonsurface = const Color(0xff191c1a);
  final Color lightsurfacevariant = const Color(0xffe7e0eb);
  final Color lightonsurfacevariant = const Color(0xff49454e);
  final Color lightinversesurface = const Color(0xff2e312e);
  final Color lightinverseonsurface = const Color(0xfff0f1ed);
  final Color lightinverseprimary = const Color(0xffd0bcff);
  final Color lightshadow = const Color(0xff000000);
  final Color lightsurfacetint = const Color(0xff702bed);
  final Color lightoutlinevariant = const Color(0xffcac4cf);
  final Color lightscrim = const Color(0xff000000);
  final Color lightsurfacecontainerhighest = const Color(0xffe1e3de);
  final Color lightsurfacecontainerhigh = const Color(0xffe7e9e4);
  final Color lightsurfacecontainer = const Color(0xffedeeea);
  final Color lightsurfacecontainerlow = const Color(0xfff2f4ef);
  final Color lightsurfacecontainerlowest = const Color(0xffffffff);
  final Color lightsurfacebright = const Color(0xfff8faf5);
  final Color lightsurfacedim = const Color(0xffd9dbd6);

  final Color darkprimary = const Color(0xffd0bcff);
  final Color darkonprimary = const Color(0xff3c0091);
  final Color darkprimarycontainer = const Color(0xff5600ca);
  final Color darkonprimarycontainer = const Color(0xffe9ddff);
  final Color darkprimaryfixed = const Color(0xffe9ddff);
  final Color darkonprimaryfixed = const Color(0xff23005c);
  final Color darkprimaryfixeddim = const Color(0xffd0bcff);
  final Color darkonprimaryfixedvariant = const Color(0xff5600ca);
  final Color darksecondary = const Color(0xffb5c4ff);
  final Color darkonsecondary = const Color(0xff00297a);
  final Color darksecondarycontainer = const Color(0xff003dab);
  final Color darkonsecondarycontainer = const Color(0xffdbe1ff);
  final Color darksecondaryfixed = const Color(0xffdbe1ff);
  final Color darkonsecondaryfixed = const Color(0xff00174c);
  final Color darksecondaryfixeddim = const Color(0xffb5c4ff);
  final Color darkonsecondaryfixedvariant = const Color(0xff003dab);
  final Color darktertiary = const Color(0xffd0bcff);
  final Color darkontertiary = const Color(0xff3c0091);
  final Color darktertiarycontainer = const Color(0xff560ec3);
  final Color darkontertiarycontainer = const Color(0xffe9ddff);
  final Color darktertiaryfixed = const Color(0xffe9ddff);
  final Color darkontertiaryfixed = const Color(0xff23005c);
  final Color darktertiaryfixeddim = const Color(0xffd0bcff);
  final Color darkontertiaryfixedvariant = const Color(0xff560ec3);
  final Color darkerror = const Color(0xffffb4ab);
  final Color darkonerror = const Color(0xff690005);
  final Color darkerrorcontainer = const Color(0xff93000a);
  final Color darkonerrorcontainer = const Color(0xffffdad6);
  final Color darkoutline = const Color(0xff948f99);
  final Color darkbackground = const Color(0xff191c1a);
  final Color darkonbackground = const Color(0xffe1e3de);
  final Color darksurface = const Color(0xff111412);
  final Color darkonsurface = const Color(0xffc5c7c3);
  final Color darksurfacevariant = const Color(0xff49454e);
  final Color darkonsurfacevariant = const Color(0xffcac4cf);
  final Color darkinversesurface = const Color(0xffe1e3de);
  final Color darkinverseonsurface = const Color(0xff191c1a);
  final Color darkinverseprimary = const Color(0xff702bed);
  final Color darkshadow = const Color(0xff000000);
  final Color darksurfacetint = const Color(0xffd0bcff);
  final Color darkoutlinevariant = const Color(0xff49454e);
  final Color darkscrim = const Color(0xff000000);
  final Color darksurfacecontainerhighest = const Color(0xff323632);
  final Color darksurfacecontainerhigh = const Color(0xff282b28);
  final Color darksurfacecontainer = const Color(0xff1d201e);
  final Color darksurfacecontainerlow = const Color(0xff191c1a);
  final Color darksurfacecontainerlowest = const Color(0xff0c0f0c);
  final Color darksurfacebright = const Color(0xff373a37);
  final Color darksurfacedim = const Color(0xff111412);

  final Color primaryprimary0 = const Color(0xff000000);
  final Color primaryprimary10 = const Color(0xff23005c);
  final Color primaryprimary20 = const Color(0xff3c0091);
  final Color primaryprimary30 = const Color(0xff5600ca);
  final Color primaryprimary40 = const Color(0xff702bed);
  final Color primaryprimary50 = const Color(0xff8951ff);
  final Color primaryprimary60 = const Color(0xffa078ff);
  final Color primaryprimary70 = const Color(0xffb89bff);
  final Color primaryprimary80 = const Color(0xffd0bcff);
  final Color primaryprimary90 = const Color(0xffe9ddff);
  final Color primaryprimary95 = const Color(0xfff6edff);
  final Color primaryprimary99 = const Color(0xfffffbff);
  final Color primaryprimary100 = const Color(0xffffffff);
  final Color primaryprimary4 = const Color(0xff13003a);
  final Color primaryprimary5 = const Color(0xff170041);
  final Color primaryprimary6 = const Color(0xff190047);
  final Color primaryprimary12 = const Color(0xff280066);
  final Color primaryprimary17 = const Color(0xff340080);
  final Color primaryprimary22 = const Color(0xff41009c);
  final Color primaryprimary24 = const Color(0xff4600a7);
  final Color primaryprimary25 = const Color(0xff4900ad);
  final Color primaryprimary35 = const Color(0xff6311e1);
  final Color primaryprimary87 = const Color(0xffe2d3ff);
  final Color primaryprimary92 = const Color(0xffeee4ff);
  final Color primaryprimary94 = const Color(0xfff3eaff);
  final Color primaryprimary96 = const Color(0xfff8f1ff);
  final Color primaryprimary98 = const Color(0xfffef7ff);

  final Color secondarysecondary0 = const Color(0xff000000);
  final Color secondarysecondary10 = const Color(0xff00174c);
  final Color secondarysecondary20 = const Color(0xff00297a);
  final Color secondarysecondary30 = const Color(0xff003dab);
  final Color secondarysecondary40 = const Color(0xff0051df);
  final Color secondarysecondary50 = const Color(0xff2e6bff);
  final Color secondarysecondary60 = const Color(0xff638aff);
  final Color secondarysecondary70 = const Color(0xff8da8ff);
  final Color secondarysecondary80 = const Color(0xffb5c4ff);
  final Color secondarysecondary90 = const Color(0xffdbe1ff);
  final Color secondarysecondary95 = const Color(0xffeff0ff);
  final Color secondarysecondary99 = const Color(0xfffefbff);
  final Color secondarysecondary100 = const Color(0xffffffff);
  final Color secondarysecondary4 = const Color(0xff000b2f);
  final Color secondarysecondary5 = const Color(0xff000d35);
  final Color secondarysecondary6 = const Color(0xff000f3a);
  final Color secondarysecondary12 = const Color(0xff001a55);
  final Color secondarysecondary17 = const Color(0xff00236c);
  final Color secondarysecondary22 = const Color(0xff002d83);
  final Color secondarysecondary24 = const Color(0xff00318d);
  final Color secondarysecondary25 = const Color(0xff003392);
  final Color secondarysecondary35 = const Color(0xff0047c4);
  final Color secondarysecondary87 = const Color(0xffd0d9ff);
  final Color secondarysecondary92 = const Color(0xffe3e7ff);
  final Color secondarysecondary94 = const Color(0xffebedff);
  final Color secondarysecondary96 = const Color(0xfff2f3ff);
  final Color secondarysecondary98 = const Color(0xfffaf8ff);

  final Color tertiarytertiary0 = const Color(0xff000000);
  final Color tertiarytertiary10 = const Color(0xff23005c);
  final Color tertiarytertiary20 = const Color(0xff3c0091);
  final Color tertiarytertiary30 = const Color(0xff560ec3);
  final Color tertiarytertiary40 = const Color(0xff6e37dc);
  final Color tertiarytertiary50 = const Color(0xff8855f6);
  final Color tertiarytertiary60 = const Color(0xffa078ff);
  final Color tertiarytertiary70 = const Color(0xffb89bff);
  final Color tertiarytertiary80 = const Color(0xffd0bcff);
  final Color tertiarytertiary90 = const Color(0xffe9ddff);
  final Color tertiarytertiary95 = const Color(0xfff6edff);
  final Color tertiarytertiary99 = const Color(0xfffffbff);
  final Color tertiarytertiary100 = const Color(0xffffffff);
  final Color tertiarytertiary4 = const Color(0xff13003a);
  final Color tertiarytertiary5 = const Color(0xff170040);
  final Color tertiarytertiary6 = const Color(0xff1a0047);
  final Color tertiarytertiary12 = const Color(0xff280066);
  final Color tertiarytertiary17 = const Color(0xff340080);
  final Color tertiarytertiary22 = const Color(0xff41009c);
  final Color tertiarytertiary24 = const Color(0xff4600a7);
  final Color tertiarytertiary25 = const Color(0xff4900ad);
  final Color tertiarytertiary35 = const Color(0xff6226cf);
  final Color tertiarytertiary87 = const Color(0xffe2d3ff);
  final Color tertiarytertiary92 = const Color(0xffeee4ff);
  final Color tertiarytertiary94 = const Color(0xfff3eaff);
  final Color tertiarytertiary96 = const Color(0xfff8f1ff);
  final Color tertiarytertiary98 = const Color(0xfffef7ff);

  final Color errorerror0 = const Color(0xff000000);
  final Color errorerror10 = const Color(0xff410002);
  final Color errorerror4 = const Color(0xff280001);
  final Color errorerror5 = const Color(0xff2d0001);
  final Color errorerror6 = const Color(0xff310001);
  final Color errorerror12 = const Color(0xff490002);
  final Color errorerror17 = const Color(0xff5c0004);
  final Color errorerror20 = const Color(0xff690005);
  final Color errorerror22 = const Color(0xff710006);
  final Color errorerror24 = const Color(0xff790007);
  final Color errorerror25 = const Color(0xff7e0007);
  final Color errorerror30 = const Color(0xff93000a);
  final Color errorerror35 = const Color(0xffa9000d);
  final Color errorerror40 = const Color(0xffc00011);
  final Color errorerror50 = const Color(0xffec131d);
  final Color errorerror60 = const Color(0xffff5449);
  final Color errorerror70 = const Color(0xffff897d);
  final Color errorerror80 = const Color(0xffffb4ab);
  final Color errorerror87 = const Color(0xffffcfc9);
  final Color errorerror90 = const Color(0xffffdad6);
  final Color errorerror92 = const Color(0xffffe2de);
  final Color errorerror94 = const Color(0xffffe9e6);
  final Color errorerror95 = const Color(0xffffedea);
  final Color errorerror96 = const Color(0xfffff0ee);
  final Color errorerror98 = const Color(0xfffff8f7);
  final Color errorerror99 = const Color(0xfffffbff);
  final Color errorerror100 = const Color(0xffffffff);

  final Color neutralneutral0 = const Color(0xff000000);
  final Color neutralneutral4 = const Color(0xff0c0f0c);
  final Color neutralneutral5 = const Color(0xff0f120f);
  final Color neutralneutral6 = const Color(0xff111412);
  final Color neutralneutral10 = const Color(0xff191c1a);
  final Color neutralneutral12 = const Color(0xff1d201e);
  final Color neutralneutral17 = const Color(0xff282b28);
  final Color neutralneutral20 = const Color(0xff2e312e);
  final Color neutralneutral22 = const Color(0xff323632);
  final Color neutralneutral24 = const Color(0xff373a37);
  final Color neutralneutral25 = const Color(0xff393c39);
  final Color neutralneutral30 = const Color(0xff444744);
  final Color neutralneutral35 = const Color(0xff505350);
  final Color neutralneutral40 = const Color(0xff5c5f5c);
  final Color neutralneutral50 = const Color(0xff757874);
  final Color neutralneutral60 = const Color(0xff8f918d);
  final Color neutralneutral70 = const Color(0xffaaaca8);
  final Color neutralneutral80 = const Color(0xffc5c7c3);
  final Color neutralneutral87 = const Color(0xffd9dbd6);
  final Color neutralneutral90 = const Color(0xffe1e3de);
  final Color neutralneutral92 = const Color(0xffe7e9e4);
  final Color neutralneutral94 = const Color(0xffedeeea);
  final Color neutralneutral95 = const Color(0xfff0f1ed);
  final Color neutralneutral96 = const Color(0xfff2f4ef);
  final Color neutralneutral98 = const Color(0xfff8faf5);
  final Color neutralneutral99 = const Color(0xfffbfdf8);
  final Color neutralneutral100 = const Color(0xffffffff);

  final Color neutralvariantneutralvariant0 = const Color(0xff000000);
  final Color neutralvariantneutralvariant4 = const Color(0xff0f0d14);
  final Color neutralvariantneutralvariant5 = const Color(0xff121017);
  final Color neutralvariantneutralvariant6 = const Color(0xff15121a);
  final Color neutralvariantneutralvariant10 = const Color(0xff1d1a22);
  final Color neutralvariantneutralvariant12 = const Color(0xff211e26);
  final Color neutralvariantneutralvariant17 = const Color(0xff2c2931);
  final Color neutralvariantneutralvariant20 = const Color(0xff322f37);
  final Color neutralvariantneutralvariant22 = const Color(0xff36333c);
  final Color neutralvariantneutralvariant24 = const Color(0xff3b3840);
  final Color neutralvariantneutralvariant25 = const Color(0xff3d3a43);
  final Color neutralvariantneutralvariant30 = const Color(0xff49454e);
  final Color neutralvariantneutralvariant35 = const Color(0xff55515a);
  final Color neutralvariantneutralvariant40 = const Color(0xff615d66);
  final Color neutralvariantneutralvariant50 = const Color(0xff7a757f);
  final Color neutralvariantneutralvariant60 = const Color(0xff948f99);
  final Color neutralvariantneutralvariant70 = const Color(0xffafa9b4);
  final Color neutralvariantneutralvariant80 = const Color(0xffcac4cf);
  final Color neutralvariantneutralvariant87 = const Color(0xffded8e3);
  final Color neutralvariantneutralvariant90 = const Color(0xffe7e0eb);
  final Color neutralvariantneutralvariant92 = const Color(0xffede6f1);
  final Color neutralvariantneutralvariant94 = const Color(0xfff2ebf7);
  final Color neutralvariantneutralvariant95 = const Color(0xfff5eefa);
  final Color neutralvariantneutralvariant96 = const Color(0xfff8f1fd);
  final Color neutralvariantneutralvariant98 = const Color(0xfffef7ff);
  final Color neutralvariantneutralvariant99 = const Color(0xfffffbff);
  final Color neutralvariantneutralvariant100 = const Color(0xffffffff);
  final Color primary = const Color(0xff6618e3);
  final Color secondary = const Color(0xff005af4);
  final Color tertiary = const Color(0xff905eff);
  final Color error = const Color(0xffe10016);
  final Color neutral = const Color(0xff090a09);
  final Color sourceseed = const Color(0xff6618e3);
}
