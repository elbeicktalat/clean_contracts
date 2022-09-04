//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

class CrowLog {
  static String error(String text) {
    return '\x1B[31m[ERROR] $text\x1B[0m';
  }

  static String warning(String text) {
    return '\x1B[33m[WARNING] $text\x1B[0m';
  }

  static String success(String text) {
    return '\x1B[32m[SUCCESS] $text\x1B[0m';
  }
}

String function({
  required String returnType,
  required String name,
  required String body,
  String? params,
  bool isPrivet = false,
}) {
  StringBuffer buffer = StringBuffer();

  buffer.writeln('$returnType ${isPrivet ? '_' : ''}$name($params) {');
  buffer.writeln(body);
  buffer.writeln('}');

  String result = buffer.toString();
  buffer.clear();
  return result;
}

String namedParameter(String name, String value) => '$name: $value';

String parameter(String value) => value;
