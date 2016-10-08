# -*- coding:utf-8 -*-
__author__ = 'Ulric Qin'
from .bean import Bean
from frame.config import MAINTAINERS
from frame.api import uic
from web.model.action import Action


class Expression(Bean):
    _tbl = 'expression'
    _cols = 'id, expression, func, op, right_value, max_step, priority, note, action_id, create_user, pause'

    def __init__(self, _id, expression, func, op, right_value, max_step, priority, note, action_id,
                 create_user, pause):
        self.id = _id
        self.expression = expression
        self.func = func
        self.op = op
        self.right_value = right_value
        self.max_step = max_step
        self.priority = priority
        self.note = note
        self.action_id = action_id
        self.create_user = create_user
        self.pause = pause
        self.action = None

    @classmethod
    def save_or_update(cls, expression_id, expression, func, op, right_value, uic_groups, max_step, priority, note, url,
                       callback, before_callback_sms, before_callback_mail,
                       after_callback_sms, after_callback_mail, login_user):
        if not expression.startswith('each('):
            return 'only support each expression. e.g. each(metric=? xx=yy)'

        if not 'metric=' in expression:
            return 'expression is invalid. e.g. each(metric=? xx=yy)'

        left = expression.find('(')
        right = expression.find(')')

        if left <= 0:
            return 'left parentheses ( not found'

        if right <= 0:
            return 'right parentheses ) not found'

        in_parentheses = expression[left + 1:right]
        in_parentheses = ' '.join(in_parentheses.replace(',', ' ').replace(';', ' ').split())
        arr = in_parentheses.split()
        arr = [item for item in arr if '=' in item]
        if len(arr) < 2:
            return 'expression is invalid. e.g. each(metric=? xx=yy)'

        expression = 'each(%s)' % in_parentheses

        if expression_id:
            return cls.update_expression(expression_id, expression, func, op, right_value, uic_groups, max_step,
                                         priority, note, url,
                                         callback, before_callback_sms, before_callback_mail,
                                         after_callback_sms, after_callback_mail)
        else:
            return cls.insert_expression(expression, func, op, right_value, uic_groups, max_step,
                                         priority, note, url, callback,
                                         before_callback_sms, before_callback_mail,
                                         after_callback_sms, after_callback_mail, login_user)

    @classmethod
    def insert_expression(cls, content, func, op, right_value, uic_groups, max_step, priority, note, url,
                          callback, before_callback_sms, before_callback_mail,
                          after_callback_sms, after_callback_mail, user_name):
        action_id = Action.insert({
            'uic': uic_groups,
            'url': url,
            'callback': callback,
            'before_callback_sms': before_callback_sms,
            'before_callback_mail': before_callback_mail,
            'after_callback_sms': after_callback_sms,
            'after_callback_mail': after_callback_mail,
        })

        if not action_id:
            return 'save action fail'

        expression_id = Expression.insert({
            'expression': content,
            'func': func,
            'op': op,
            'right_value': right_value,
            'max_step': max_step,
            'priority': priority,
            'note': note,
            'action_id': action_id,
            'create_user': user_name
        })

        if expression_id:
            return ''

        return 'save expression fail'

    @classmethod
    def update_expression(cls, expression_id, content, func, op, right_value, uic_groups, max_step, priority, note, url,
                          callback, before_callback_sms, before_callback_mail,
                          after_callback_sms, after_callback_mail):
        e = Expression.get(expression_id)
        if not e:
            return 'no such expression %s' % expression_id

        a = Action.get(e.action_id)
        if not a:
            return 'no relation action'

        Action.update_dict(
            {
                'uic': uic_groups,
                'url': url,
                'callback': callback,
                'before_callback_sms': before_callback_sms,
                'before_callback_mail': before_callback_mail,
                'after_callback_sms': after_callback_sms,
                'after_callback_mail': after_callback_mail
            },
            'id=%s',
            [a.id]
        )

        Expression.update_dict(
            {
                'expression': content,
                'func': func,
                'op': op,
                'right_value': right_value,
                'max_step': max_step,
                'priority': priority,
                'note': note,
            },
            'id=%s',
            [e.id]
        )
        return ''

    @classmethod
    def query(cls, page, limit, query, me=None):
        where = ''
        params = []

        if me is not None:
            where = 'create_user = %s'
            params.append(me)

        if query:
            where += ' and ' if where else ''
            where += 'expression like %s'
            params.append('%' + query + '%')

        vs = cls.select_vs(where=where, params=params, page=page, limit=limit)
        total = cls.total(where=where, params=params)
        return vs, total

    def writable(self, login_user):
        if self.create_user == login_user:
            return True

        if login_user in MAINTAINERS:
            return True

        a = self.action
        if not a:
            return False

        if not a.uic:
            return False

        return uic.email_in_groups(login_user, a.uic)

    def to_json(self):
        return {
            "id": self.id,
            "expression": self.expression,                       
            "func": self.func,
            "op": self.op,
            "right_value": self.right_value,
            "max_step": self.max_step,
            "priority": self.priority,
            "note": self.note,
            "action_id": self.action_id
        }
